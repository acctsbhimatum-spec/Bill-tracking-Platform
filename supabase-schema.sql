-- Run this once in Supabase: Project → SQL Editor → New query → paste → Run

create table if not exists app_kv (
  key text primary key,
  value jsonb not null,
  updated_at timestamptz not null default now()
);

alter table app_kv enable row level security;

-- Permissive policies: this app authenticates users itself (branch/department/admin
-- logins with passwords stored inside the 'value' JSON), not via Supabase Auth, so
-- the anon key needs open read/write on this one table. See README.md for the
-- security trade-off this implies.
create policy "anon read app_kv" on app_kv
  for select using (true);

create policy "anon write app_kv" on app_kv
  for insert with check (true);

create policy "anon update app_kv" on app_kv
  for update using (true);
