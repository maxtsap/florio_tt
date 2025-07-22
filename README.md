


## 🚀 Getting Started with Docker

This guide explains how to run the application using Docker from a clean setup — ideal for test projects or first-time contributors.

### ✅ Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running
- `config/master.key` and `.env` files (committed for the purpose of this test task)  
  
---

### 📦 Initial Setup (Clean Start)

If you've already run the app before and want to start fresh:

```bash
docker compose down -v --remove-orphans
docker image rm florio_tt_web || true
rm -rf tmp/* log/* storage/*
```

---

### 🔧 Setup After Cloning

1. **Create a `.env` file** (optional for this task):

```bash
cp .env.example .env
```

Make sure it includes:

```env
RAILS_MASTER_KEY=your_master_key_here
```

> If the `config/master.key` file is already committed (as in this test task), you can skip this.

---

2. **Build the Docker image:**

```bash
docker compose build
```

---

3. **Install dependencies and setup the database:**

```bash
docker compose run --rm web bundle install
docker compose run --rm web ./bin/rails db:create db:migrate db:seed
```

---

### ▶️ Run the Application

```bash
docker compose up
```

The app will be available at:

```
http://localhost:3000
```

---

### 🔍 Useful Commands

| Task                          | Command                                           |
|-------------------------------|---------------------------------------------------|
| Rails console                 | `docker compose exec web ./bin/rails console`    |
| Open a shell inside container | `docker compose exec web bash`                   |
| Run migrations                | `docker compose run --rm web ./bin/rails db:migrate` |
| View logs                     | `docker compose logs -f web`                     |
| Stop containers               | `docker compose down`                            |
| Rebuild from scratch          | `docker compose build --no-cache`                |

---

### 🧪 Notes

- This Docker setup is optimized for **production builds**. For full-featured development experience, consider using DevContainers or overriding the Compose file.
- The `config/master.key` is included in the repository **only for test purposes**. **Do not commit this key in production projects.**


## 🧭 Project Overview

This application uses a **REST API** architecture. The reason for choosing REST is:

- It’s a well-established, widely supported standard
- It allows for stateless, scalable and easily testable APIs
- It fits the nature of the application which involves predictable CRUD-like operations

REST makes it easy to integrate with various frontend clients or external services without requiring complex protocol layers.

---

### ✅ CI/CD Integration

This project is configured with **GitHub Actions** to automatically run:

- ✅ RSpec tests
- ✅ RuboCop lint checks

This ensures that all pull requests and commits maintain code quality and pass validation before being merged.
