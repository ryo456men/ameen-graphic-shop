# GDShop Backend Deployment Guide

## Deploying to Render (Free Hosting)

Your backend is configured to auto-deploy on [Render](https://render.com), a free Node.js hosting platform. A `Dockerfile` is included for reliable containerized deployment.

### Step 1: Connect Your GitHub Repo to Render

1. Go to https://render.com and sign up (free)
2. Click **New +** → **Web Service**
3. Select **Deploy an existing Git repository**
4. Paste your repo URL: `https://github.com/ryo456men/ameen-graphic-shop`
5. Click **Connect**

### Step 2: Configure the Service

- **Name:** `gdshop-backend` (or your choice)
- **Environment:** Docker (Render will auto-detect the Dockerfile)
- **Plan:** Free

### Step 3: Add Environment Variables

Under **Environment**, add:
- **GDSHOP_SECRET:** `changeme_secret_prod` (change to a strong secret)
- **PORT:** `4000` (optional)

Click **Create Web Service** and wait ~2 minutes for deployment.

### Step 4: Get Your Public URL

Once deployed, Render will show your service URL like:
```
https://gdshop-backend-xxxxx.onrender.com
```

### Step 5: Configure Your Site to Use the Backend

1. Open your site in a browser
2. Sign in as admin
3. Go to **Admin → Backup**
4. In the **Remote sync** section:
   - **Endpoint URL:** `https://gdshop-backend-xxxxx.onrender.com/data`
   - **Secret key:** `changeme_secret_prod` (must match what you set in Render)
5. Click **Save config**

### Step 6: Test Push/Pull

- Click **Push to server** to upload your current site data
- Data is now backed up on the Render server
- On any device/browser, you can:
  1. Configure the same endpoint + secret in Admin → Backup
  2. Click **Pull from server** to load your data

## Local Development

To test locally without deploying:

```powershell
# Terminal 1: Start backend
node server.js

# Terminal 2: Open site
# Visit http://localhost:8080
# Admin → Backup
# Endpoint: http://localhost:4000/data
# Secret: changeme_secret
```

## Production Best Practices

- Change the default secret in `server.js` to something strong
- Set `GDSHOP_SECRET` env var in Render dashboard (never hardcode in code)
- Add HTTPS to your frontend (GitHub Pages includes this)
- Consider adding a database (MongoDB, PostgreSQL) instead of file-based storage for reliability

## Troubleshooting

**"Remote error: 401"**
- Secret key mismatch between frontend and backend
- Check GDSHOP_SECRET in Render dashboard matches what you entered in Admin → Backup

**"Cannot connect to endpoint"**
- Check that your Render URL is correct (should be `https://...` not `http://...`)
- Ensure Render service is deployed and running (check Render dashboard)

**Data not syncing**
- Confirm the endpoint is saved in Admin → Backup
- Check browser console (F12) for error messages
