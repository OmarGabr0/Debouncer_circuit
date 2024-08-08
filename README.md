# Debouncer_circuit
A denouncing circuit's goal is to reduce or completely remove the effects of button bouncing. 

only one clean and stable logic level is generated. By filtering out the bouncing noise, the denouncing circuit produces a consistent and reliable digital signal.

The delay detection debouncing technique: The circuit waits for a predetermined amount of time, known as the debounce delay, when a switch is pressed or released before identifying the new stable state. Any bouncing or transient changes in the switch signal are ignored during the delay period

Recenlty.. This project contian only RTL design codes using verilog, Test-bench code and PDF file contain wave form.
But I may add synthesis file, formal verification file and dft   

![image](https://github.com/user-attachments/assets/9c38c6cb-de4f-4293-bc8c-d3005dd77f9e)
#Main Modules:
1- Bit synchronizer 

2- FSM 

3- Timer 

4- TOP module 

5- Test Bench  

#Modelsim results  

![image](https://github.com/user-attachments/assets/c0b33847-6e69-4849-a87c-cedc8d6f2d8e)


![image](https://github.com/user-attachments/assets/773fc8e0-e605-4a82-98fc-7469874735de)

