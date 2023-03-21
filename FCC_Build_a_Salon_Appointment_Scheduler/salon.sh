#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
#$PSQL "TRUNCATE TABLE appointments, customers"
echo -e "\n~~~ Welcome to the Salon Appointment Booker ~~~\n"

MAIN () {
  # Choose service
  PICK_SERVICE
  echo -e "\nYou have selected: $SERVICE_NAME."
  
  # Enter phone number and add new customer if necessary
  CUSTOMER_LOOKUP
  echo -e "\nHello $CUSTOMER_NAME, let's book your appointment."

  # Book appointment
  BOOK_APPOINTMENT

  # Confirm appointment details
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  exit
}

PICK_SERVICE () {
  # Get services
  AVAILABLE_SERVICES=$($PSQL "SELECT * FROM services")  

  echo -e "\nPlease choose a sevice:"
  #List services
  echo "$AVAILABLE_SERVICES" | while read service_id BAR NAME
  do
    echo "$service_id) $NAME" 
  done

  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^1$|^2$|^3$|^4$|^5$ ]]
  then
    echo -e "\nPlease choose a valid option."
    PICK_SERVICE
  else
    # Get service name
    SERVICE_NAME=$(echo $($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED") | sed 's/^ +//')
  fi
}

CUSTOMER_LOOKUP () {
  # Enter phone number
  echo -e "\nPlease enter your phone number."
  read CUSTOMER_PHONE

  # Look up phone number and get customer id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  # Check if repeat customer
  if [[ -z $CUSTOMER_ID ]]
  then
    # Ask for name
    echo -e "\nLooks like you're a new customer, please enter your name."
    read CUSTOMER_NAME
    # Insert new customer
    INSERT_NEW_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
    # Get new customer id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  else
    # Get customer name
    CUSTOMER_NAME=$(echo $($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'") | sed 's/^ +//')
    echo -e "\nWelcome back!"
  fi

}

BOOK_APPOINTMENT () {
  # Ask for appointment time
  echo -e "\nWhat time would you like to book your appointment?"
  read SERVICE_TIME

  # Create new appointment
  CREATE_APT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
  
}

MAIN
