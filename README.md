# Stock Management Project for Apae de São João da Boa Vista

This repository is part of a project developed as a college assignment, in partnership with the NGO Apae de São João da Boa Vista. The initiative aims to create an application to automate the management of the stock of supplies used in feeding the school's students, providing snacks and lunches. This software arises from the need for strict control of the expiration dates of supplies, ensuring the quality and safety of the food provided.

To meet this demand, we developed a robust MySQL database with several automations such as triggers, procedures, functions, and events, which ensure the control of expiration dates and the movement of items in the inventory. The application consists of three main components:

- **Backend**: An API developed in Node.js, responsible for communication with the database and system logic.
- **Frontend**: A web interface created in Angular 17, which allows users to interact intuitively with the inventory management system.
- **Database**: A MySQL database that stores all information related to supplies, including their expiration dates and inventory status.

## Repository Structure

- **database/**: Contains SQL scripts for creating tables, triggers, procedures, functions, and events.
- **backend/**: Implementation of the API in Node.js, following the MVC (Model-View-Controller) pattern to ensure code organization and maintainability.
- **frontend/**: Web application code developed in Angular 17.

## How to Run the Project

To run the project locally, follow these steps:

### 1. Clone the Repository

Clone the repository to your local machine using the command:

```bash
git clone https://github.com/your-username/your-repository.git
```

### 2. Database

1. Navigate to the `database` folder and execute the SQL scripts on your MySQL server to create the database and set up all tables and automations.
2. Make sure MySQL is running and properly configured.

### 3. Backend (API)

1. Navigate to the `backend` folder.
2. Install the necessary dependencies using npm:

```bash
npm install
```

3. Configure the environment variables for database connection (you can create a `.env` file with the credentials).
4. Start the Node.js server:

```bash
npm start
```

### 4. Frontend

1. Navigate to the `frontend` folder.
2. Install the necessary dependencies using npm:

```bash
npm install
```

3. Start the Angular development server:

```bash
ng serve
```

4. Access the application in the browser at `http://localhost:4200`.

## Instructions to Fully Run the API

### 1. Configure .env File:

```bash
./env.txt > .env
```

### 2. Create Database:

```bash
./database/schema.sql
```

### 3. Create Admin User

```bash
node ./database/first_user.js
```

### 4. Populate Database

```bash
./database/inser_completo.sql
```

### 5. Add Daily Event

```bash
./database/event_atualizar_status_estoque.sql
```

## Main Features

- **Inventory Control**: View items in stock, highlighting items nearing their expiration date.
- **Process Automation**: The use of triggers and events ensures that expired items are moved to the correct table, facilitating control.
- **User-Friendly Interface**: The interface developed in Angular allows intuitive navigation for NGO users.

## Diagrams

Diagrams will be added soon to better illustrate the project structure. We intend to include a diagram explaining the logical model of the database to help understand how the tables are related and how supply management is handled.

## License

This project is for internal use by Apae de São João da Boa Vista and is being developed for academic purposes.

