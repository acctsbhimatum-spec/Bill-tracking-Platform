# Bill Dāk — Movement & Approval Register

Static single-file app (`index.html`) backed by a Supabase table for shared,
persistent data. No build step — deploy as-is.

## Setup

1. Create a Supabase project.
2. Open the SQL Editor and run `supabase-schema.sql`.
3. Go to Project Settings → API and copy the Project URL and anon public key.
4. Open `index.html` and set `SUPABASE_URL` and `SUPABASE_ANON_KEY` near the top
   of the `<script>` block.
5. Push to GitHub, then import the repo into Vercel (framework preset: "Other",
   no build command, output directory: `/`).

## Security note

Branch/department/admin logins and passwords live inside a single JSON blob in
the `app_kv` table, readable and writable by anyone holding the public anon
key (which is visible in the deployed page's source). This matches the app's
original in-artifact prototype behaviour but is **not** hardened for
production use with real financial data. Before relying on this for real
bills, at minimum:

- Change every login off the default password `0000` immediately after first
  deploy.
- Consider replacing the custom login system with real Supabase Auth and
  per-row Row Level Security.
- Consider moving credential checks into a Postgres function / Edge Function
  instead of the open policies above.
