# Node.js MySQL Authentication App

A Node.js application with MySQL database integration using Sequelize ORM, featuring user registration and login functionality.

## Features

- ✅ MySQL database connection with Sequelize
- ✅ User registration with validation
- ✅ User login with JWT authentication
- ✅ Password hashing with bcrypt
- ✅ Input validation with express-validator
- ✅ CORS support
- ✅ Environment-based configuration

## Prerequisites

- Node.js (v14 or higher)
- MySQL Server
- npm or yarn

## Installation

1. **Clone or download the project**

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Set up MySQL database:**
   - Create a MySQL database named `nodejs_app`
   - Update the `.env` file with your MySQL credentials

4. **Configure environment variables:**
   Edit the `.env` file with your settings:
   ```env
   DB_HOST=localhost
   DB_PORT=3306
   DB_NAME=nodejs_app
   DB_USER=your_mysql_username
   DB_PASSWORD=your_mysql_password
   JWT_SECRET=your_jwt_secret_key_here
   ```

## Database Setup

1. **Run migrations:**
   ```bash
   npm run migrate
   ```

   This will create the `users` table with the following columns:
   - `id` (Primary Key, Auto Increment)
   - `firstName` (VARCHAR, NOT NULL)
   - `lastName` (VARCHAR, NOT NULL)
   - `email` (VARCHAR, UNIQUE, NOT NULL)
   - `phone` (VARCHAR, NULL)
   - `password` (VARCHAR, NOT NULL)
   - `createdAt` (TIMESTAMP)
   - `updatedAt` (TIMESTAMP)

## Running the Application

1. **Development mode:**
   ```bash
   npm run dev
   ```

2. **Production mode:**
   ```bash
   npm start
   ```

The server will start on `http://localhost:3000`

## API Endpoints

### Authentication

#### Register User
```http
POST /api/auth/register
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "phone": "+1234567890",
  "password": "Password123"
}
```

#### Login User
```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "john.doe@example.com",
  "password": "Password123"
}
```

#### Get User Profile
```http
GET /api/auth/profile
Authorization: Bearer <your_jwt_token>
```

### Health Check
```http
GET /health
```

## Project Structure

```
nodejs/
├── config/
│   ├── config.js          # Sequelize CLI configuration
│   └── database.js        # Database connection
├── controllers/
│   └── authController.js  # Authentication logic
├── middleware/
│   ├── auth.js           # JWT authentication middleware
│   └── validation.js     # Input validation rules
├── migrations/
│   └── 20240101000000-create-users.js  # User table migration
├── models/
│   └── User.js           # User model
├── routes/
│   └── auth.js           # Authentication routes
├── .env                  # Environment variables
├── package.json          # Dependencies and scripts
├── server.js             # Main application file
└── README.md             # This file
```

## Validation Rules

### Registration
- **firstName**: 2-50 characters, letters and spaces only
- **lastName**: 2-50 characters, letters and spaces only
- **email**: Valid email format
- **phone**: Optional, valid phone number format
- **password**: Minimum 6 characters, must contain uppercase, lowercase, and number

### Login
- **email**: Valid email format
- **password**: Required

## Security Features

- Password hashing with bcrypt (10 salt rounds)
- JWT token authentication
- Input validation and sanitization
- CORS protection
- SQL injection prevention through Sequelize ORM

## Development

### Available Scripts

- `npm start` - Start the server in production mode
- `npm run dev` - Start the server in development mode with nodemon
- `npm run migrate` - Run database migrations
- `npm run migrate:undo` - Undo the last migration
- `npm run seed` - Run database seeds (if available)

### Database Management

The application uses Sequelize CLI for database operations. You can create additional migrations and models as needed.

## Testing the API

You can test the API using tools like:
- Postman
- curl
- Thunder Client (VS Code extension)

### Example curl commands:

**Register:**
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com",
    "phone": "+1234567890",
    "password": "Password123"
  }'
```

**Login:**
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john.doe@example.com",
    "password": "Password123"
  }'
```

## Troubleshooting

1. **Database connection issues:**
   - Ensure MySQL server is running
   - Check database credentials in `.env`
   - Verify database exists

2. **Migration issues:**
   - Run `npm run migrate` to create tables
   - Check MySQL user permissions

3. **JWT token issues:**
   - Ensure `JWT_SECRET` is set in `.env`
   - Check token expiration

## License

ISC