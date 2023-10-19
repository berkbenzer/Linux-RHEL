
def delete_usernames_oracle(conn, usernames):
    # Delete each username from the database
    for username in usernames:
        # Check if the user exists in the database
        query = "select username from all_users where username = %s"
        cursor = conn.cursor()
        cursor.execute(query, (username,))
        results = cursor.fetchall()

        if results:
            for result in results:
                user_name = result[0]
                
                print("%s found in the database" % (user_name))

                if prompt_confirmation(user_name):
                    delete_user_mysql(conn, user_name)
                    print("%s deleted from the database" % (user_name))
                else:
                    print("%s deletion canceled" % (user_name))
        else:
            print("%s not found in the database" % username)

def delete_user_oracle(conn, user_name):
    # Create a cursor for executing the DROP USER query
    cursor = conn.cursor()
    drop_query = "DROP USER %s CASCADE"
    cursor.execute(drop_query, (user_name))

    # Commit the changes to the database
    conn.commit()
    cursor.close()
