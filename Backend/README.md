# Database
First you need to set up a database:
[Setup PostgreSQL database](./Database/)
# Backend - Installation and setup

## 1. Create a virtual environment and install the required dependencies:

   ```sh
   python -m venv env
   env/Scripts/activate
   pip install -r requirements.txt
   ```
## 2. Create a config.txt file in the env folder and then save two attributes in it:

   ```sh
   PASSWORD=WRITE YOUR PASSWORD HERE
   DATABASE_NAME=WRITE YOUR DATABASE NAME HERE
   ```
## 3. You are all set! To run the backend type:
   ```sh
   python app.py
   ```


[If you're all set, continue configuring frontend](https://github.com/Freddy-Ms/AlkoHub-Website/tree/main/Frontend)
