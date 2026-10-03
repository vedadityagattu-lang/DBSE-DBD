# DINE v4 — Expanded Menu Upgrade

Based on DINE-Premium-OneClick-Phone-DB-Fixed-v3.

60 dishes across Starters, Main Course, Breads & Rice, Beverages and Desserts. Every dish has a local photo. Presentation navigation/page and academic/stack labels have been removed from the web interface. Technical explanation files remain in docs for your own reference.

## Upgrade an already configured v3 installation

1. Stop the frontend and backend terminals.
2. Copy the new frontend/src, frontend/public/menu, database/seed.sql, database/upgrade_menu_v4.sql, scripts/update_menu.py and UPDATE_MENU.bat into your existing DINE-Premium folder. Keep your existing backend/.env, frontend/.env and virtual environment.
3. From a CMD terminal opened in the DINE-Premium folder, run:

```bat
mysql -u root -p < database\upgrade_menu_v4.sql
```

Alternatively run UPDATE_MENU.bat in the existing configured folder. It uses backend/.env and the installed backend dependencies.
4. Restart FastAPI and React using your usual commands. Refresh the browser. Production deployments must rebuild the frontend and apply the SQL migration to their configured database.

The menu-only SQL keeps existing menu IDs, orders, payment history, table status and sold-out settings. It adds missing dishes and updates existing descriptions, prices and photos. Applying it again does not duplicate dishes. Do not use the older reset/setup workflow to apply this menu-only upgrade.

## Fresh installation

Use the existing setup instructions and configure MySQL/FastAPI/React. The seed.sql file now contains the full 60-dish menu. Local pictures ship under frontend/public/menu and do not require a third-party photo server at runtime.

## Verify in MySQL

```sql
USE dine_db;
SELECT c.name, COUNT(*) AS dishes FROM categories c JOIN menu_items m ON m.category_id=c.id GROUP BY c.id,c.name;
SELECT name,image_url FROM menu_items ORDER BY category_id,id;
```

Each of the five built-in categories has 12 dishes. Existing custom menu items are retained, so upgraded databases with custom additions may have more than 60.

Photo sources and license details are in docs/MENU_PHOTO_CREDITS.md.
