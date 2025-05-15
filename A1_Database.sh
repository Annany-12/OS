create_database()
{
	if [ -e std.dat ]
	then
		echo "Database already created"
		read stay
	else
		touch std.dat
		echo "Database created successfully"
	fi
}

view_database()
{
	if [ -e std.dat ]
	then
		echo "Rollno   Name     M1   M2   M3   M4   M5   Total   Percent"
		sort -n std.dat 
		read stay
	else
		echo "Database not yet created"
		read stay
	fi
}

# view_database()
# {
# 	if [ -e std.dat ]
# 	then
# 		echo "-----------------------------------------------------------------------------"
# 		echo "Rollno	Name	Marks1	Marks2	Marks3	Marks4	Marks5	Total	Percent"
# 		echo "-----------------------------------------------------------------------------"
# 		sort -n std.dat 
# 		echo "-----------------------------------------------------------------------------"
# 		read stay
# 	else
# 		echo "Database not yet created"
# 		read stay
# 	fi
# }

insert_data()
{
	if [ -e std.dat ]
	then
		echo "Enter student ROLL NO: "
		read roll
		if grep -q "^$roll" std.dat
		then 
			echo "Error:roll no already exist"
			return 1
		fi
		echo "Enter student NAME:"
		read name
		echo "Enter marks1:"
		read m1
		echo "Enter marks2:"
		read m2
		echo "Enter marks3:"
		read m3
		echo "Enter marks4:"
		read m4
		echo "Enter marks5:"
		read m5
		
		total=$((m1 + m2 + m3 + m4 + m5))
		percent=`expr 100 \* $total / 500`
		echo "$roll\t$name\t$m1\t$m2\t$m3\t$m4\t$m5\t$total\t$percent" >> std.dat
		return 0
	else
		echo "Database not yet created"
		return 1
	fi
}

delete_record()
{
	echo "Enter student ROLL NO to delete: "
	read roll
	if [ -e std.dat ]
	then
		grep -v "^$roll" std.dat > temp.dat
		mv temp.dat std.dat
		echo "Record deleted successfully"
	else
		echo "Database not found"
	fi
}

# modify_record()
# {
# 	echo "Enter student ROLL NO to modify: "
# 	read roll
# 	echo "Enter new student NAME: "
# 	read new_name
# 	if [ -e std.dat ]
# 	then
# 		grep -v "^$roll" std.dat > temp.dat
# 		old_record=$(grep "^$roll" std.dat)
# 		m1=$(echo $old_record | cut -f3)
# 		m2=$(echo $old_record | cut -f4)
# 		m3=$(echo $old_record | cut -f5)
# 		m4=$(echo $old_record | cut -f6)
# 		m5=$(echo $old_record | cut -f7)
# 		total=$((m1 + m2 + m3 + m4 + m5))
# 		percent=$((100 * total / 500))
# 		echo -e "$roll\t$new_name\t$m1\t$m2\t$m3\t$m4\t$m5\t$total\t$percent" >> temp.dat

# 		mv temp.dat std.dat
# 		echo "Record modified successfully"
# 	else
# 		echo "Database not found"
# 	fi
# } 

modify_record()
{
    echo "Enter student ROLL NO to modify: "
    read roll
    echo "Enter new student NAME: "
    read new_name

    if [ -e std.dat ]
    then
        old_record=$(grep "^$roll" std.dat)
        if [ -z "$old_record" ]; then
            echo "Record not found"
            return
        fi

        grep -v "^$roll" std.dat > temp.dat

        old_roll=$(echo "$old_record" | cut -f1)
        old_name=$(echo "$old_record" | cut -f2)
        m1=$(echo "$old_record" | cut -f3)
        m2=$(echo "$old_record" | cut -f4)
        m3=$(echo "$old_record" | cut -f5)
        m4=$(echo "$old_record" | cut -f6)
        m5=$(echo "$old_record" | cut -f7)
        total=$(echo "$old_record" | cut -f8)
        percent=$(echo "$old_record" | cut -f9)

        echo "$roll\t$new_name\t$m1\t$m2\t$m3\t$m4\t$m5\t$total\t$percent" >> temp.dat

        mv temp.dat std.dat

        echo "Name updated successfully"
    else
        echo "Database not found"
    fi
}

display_result()
{
    echo "Enter student ROLL NO to view result: "
    read roll
    if [ -e std.dat ]
    then
        result=$(grep "^$roll" std.dat)
        if [ -n "$result" ]
        then
            echo "Rollno   Name     M1   M2   M3   M4   M5   Total   Percent"
            echo "$result"
        else
            echo "No record found for Roll No: $roll"
        fi
    else
        echo "Database not found"
    fi
}


# display_result()
# {
#     echo "Enter student ROLL NO to view result: "
#     read roll
#     if [ -e std.dat ]
#     then
#         result=$(grep "^$roll" std.dat)
#         if [ -n "$result" ]
#         then
#             echo "Rollno  Name	Marks1   Marks2   Marks3   Marks4   Marks5   Total   Percent"
#             echo "$result"
#         else
#             echo "No record found for Roll No: $roll"
#         fi
#     else
#         echo "Database not found"
#     fi
# }

delete_database()
{
	if [ -e std.dat ]
	then
		rm std.dat
		echo "Database deleted successfully"
	else
		echo "Database not found"
	fi
}

echo "Student database........"
while true
do 
	echo "Enter your Choice:"
	echo "\n1. Create database \n2. View database \n3. Insert record \n4. Delete record \n5. Modify record \n6. Delete database \n7. Display result \n8 . Exit"
	read ch

	case $ch in
		1)
			create_database
			;;
		2)
			view_database
			;;
		3)
			insert_data
			if [ $? -eq 0 ]
			then
				echo "Record inserted successfully"
			else
				echo "Failed to insert record"
			fi
			;;
		4)
			delete_record
			;;
		5)
			modify_record
			;;
		6)
			delete_database
			;;
            
           	7)	display_result
            		;;

		8)
			exit
			;;
		*)
			echo "Incorrect choice"
			;;
	esac
done

// chmod +x name.sh //(Change mod to execution)
// ./name.sh -OR- bash name.sh (Run the command)













// ==================================================================================================================











create_database()
{
	if [ -e std.dat ]  # Check if file std.dat exists
	then
		echo "Database already created"
		read stay  # Pause and wait for user input (acts like a press enter to continue)
	else
		touch std.dat  # Create the file std.dat
		echo "Database created successfully"
	fi
}

view_database()
{
	if [ -e std.dat ]  # Check if file std.dat exists
	then
		echo "Rollno   Name     M1   M2   M3   M4   M5   Total   Percent"
		sort -n std.dat  # Sort the file numerically by roll number and display it
		read stay  # Pause to let the user see output
	else
		echo "Database not yet created"
		read stay
	fi
}

insert_data()
{
	if [ -e std.dat ]  # Check if file std.dat exists
	then
		echo "Enter student ROLL NO: "
		read roll
		if grep -q "^$roll" std.dat  # Search for roll number at beginning of a line
		then 
			echo "Error:roll no already exist"
			return 1  # Return failure status
		fi
		echo "Enter student NAME:"
		read name
		echo "Enter marks1:"
		read m1
		echo "Enter marks2:"
		read m2
		echo "Enter marks3:"
		read m3
		echo "Enter marks4:"
		read m4
		echo "Enter marks5:"
		read m5
		
		total=$((m1 + m2 + m3 + m4 + m5))  # Arithmetic expansion to get total
		percent=`expr 100 \* $total / 500`  # Old-style command substitution using expr
		echo "$roll\t$name\t$m1\t$m2\t$m3\t$m4\t$m5\t$total\t$percent" >> std.dat  # Append record to file
		return 0  # Return success
	else
		echo "Database not yet created"
		return 1
	fi
}

delete_record()
{
	echo "Enter student ROLL NO to delete: "
	read roll
	if [ -e std.dat ]
	then
		grep -v "^$roll" std.dat > temp.dat  # Save all lines that don't match roll number to temp file
		mv temp.dat std.dat  # Replace original file with updated one
		echo "Record deleted successfully"
	else
		echo "Database not found"
	fi
}

modify_record()
{
    echo "Enter student ROLL NO to modify: "
    read roll
    echo "Enter new student NAME: "
    read new_name

    if [ -e std.dat ]  # Check if database file exists
    then
        old_record=$(grep "^$roll" std.dat)  # Capture line with that roll number
        if [ -z "$old_record" ]; then  # Check if result is empty
            echo "Record not found"
            return
        fi

        grep -v "^$roll" std.dat > temp.dat  # Remove old record and save rest to temp
        old_roll=$(echo "$old_record" | cut -f1)  # Extract each field using tab as delimiter
        old_name=$(echo "$old_record" | cut -f2)
        m1=$(echo "$old_record" | cut -f3)
        m2=$(echo "$old_record" | cut -f4)
        m3=$(echo "$old_record" | cut -f5)
        m4=$(echo "$old_record" | cut -f6)
        m5=$(echo "$old_record" | cut -f7)
        total=$(echo "$old_record" | cut -f8)
        percent=$(echo "$old_record" | cut -f9)

        echo "$roll\t$new_name\t$m1\t$m2\t$m3\t$m4\t$m5\t$total\t$percent" >> temp.dat  # Add updated record

        mv temp.dat std.dat  # Replace old file with new updated one

        echo "Name updated successfully"
    else
        echo "Database not found"
    fi
}

display_result()
{
    echo "Enter student ROLL NO to view result: "
    read roll
    if [ -e std.dat ]
    then
        result=$(grep "^$roll" std.dat)  # Search for line matching roll number
        if [ -n "$result" ]  # Check if non-empty
        then
            echo "Rollno   Name     M1   M2   M3   M4   M5   Total   Percent"
            echo "$result"
        else
            echo "No record found for Roll No: $roll"
        fi
    else
        echo "Database not found"
    fi
}

delete_database()
{
	if [ -e std.dat ]  # Check if file exists
	then
		rm std.dat  # Remove the file
		echo "Database deleted successfully"
	else
		echo "Database not found"
	fi
}

# ----- Main Menu Loop -----
echo "Student database........"
while true
do 
	echo "Enter your Choice:"
	echo "\n1. Create database \n2. View database \n3. Insert record \n4. Delete record \n5. Modify record \n6. Delete database \n7. Display result \n8 . Exit"
	read ch

	case $ch in
		1)
			create_database
			;;
		2)
			view_database
			;;
		3)
			insert_data
			if [ $? -eq 0 ]  # Check if last command was successful
			then
				echo "Record inserted successfully"
			else
				echo "Failed to insert record"
			fi
			;;
		4)
			delete_record
			;;
		5)
			modify_record
			;;
		6)
			delete_database
			;;
		7)
			display_result
			;;
		8)
			exit  # Exit the program
			;;
		*)
			echo "Incorrect choice"
			;;
	esac
done

# Run instructions:
# chmod +x name.sh     # Make the script executable
# ./name.sh            # OR bash name.sh to execute
