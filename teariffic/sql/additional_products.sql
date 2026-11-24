-- Additional Teariffic menu products (safe to run more than once)
-- Run in Supabase Dashboard > SQL Editor after the schema is installed.

insert into public.categories(name) values
  ('Fruit Tea'), ('Classic Milk Tea'), ('Cream Cheese'), ('Coffee & Specials')
on conflict (name) do nothing;

insert into public.products(category_id, name, description, price, active)
select c.id, v.name, v.description, v.price, true
from (values
  ('Classic Milk Tea', 'Okinawa Milk Tea', 'Toasty brown sugar notes blended with smooth milk tea.', 109.00),
  ('Classic Milk Tea', 'Taro Milk Tea', 'Creamy, mellow taro milk tea with a lightly sweet finish.', 115.00),
  ('Fruit Tea', 'Strawberry Fruit Tea', 'Refreshing fruit tea with bright strawberry flavor.', 99.00),
  ('Fruit Tea', 'Passion Fruit Tea', 'Tangy passion fruit tea for a tropical, refreshing sip.', 105.00),
  ('Cream Cheese', 'Wintermelon Cheese Foam', 'Smooth wintermelon tea finished with rich cheese foam.', 125.00),
  ('Coffee & Specials', 'Caramel Coffee Milk Tea', 'Milk tea with coffee notes and a caramel finish.', 135.00)
) as v(category_name, name, description, price)
join public.categories c on c.name = v.category_name
where not exists (
  select 1 from public.products p where lower(p.name) = lower(v.name)
);
