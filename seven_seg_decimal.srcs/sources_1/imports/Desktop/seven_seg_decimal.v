


module seven_seg_decimal(
    input clk,
    input reset, 
    input sw1,
    input sw2,
    input sw3,
    input sw4,
    input sw5,
    input sw6,
    output reg led1,
    output reg led2,
    output reg led3,       
    output reg [3:0] Anode_Activate, 
    output reg [6:0] LED_out
    );
    
    reg [15:0] displayed_number = 0; 
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter;    
    wire [1:0] LED_activating_counter; 
    reg [31:0] delaycounter =0;
        
    always @(posedge clk)
    begin 
        if(reset==1)
            begin
                refresh_counter <= 0;
                displayed_number <= 0000;
            end
        else if (sw1==1)
            begin
                displayed_number <= 1;
            end
        else if (sw2==1)
            begin
                displayed_number <= 2;
            end
       else if (sw3==1)
            begin
                displayed_number <= 3;
            end
        else if (sw4==1)
            begin
            if(delaycounter[25]==1)
                begin
                    displayed_number <= displayed_number + 1;
                    delaycounter <= 0;
                end
            else
                begin
                    delaycounter <= delaycounter + 1;
                end
            end
        else if (sw5==1)
            begin
                led1 <= 1;
                led2 <= 0;
            end
       else if (sw6==1)
            begin
                led2 <= 1;
                led1 <= 0;
            end
        else
            refresh_counter <= refresh_counter + 1;
    end 
    
    assign LED_activating_counter = refresh_counter[19:18];
    
    
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = displayed_number/1000;
            // the first digit of the 16-bit number
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = (displayed_number % 1000)/100;
            // the second digit of the 16-bit number
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = ((displayed_number % 1000)%100)/10;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = ((displayed_number % 1000)%100)%10;
            // the fourth digit of the 16-bit number    
               end
        endcase
    end
    
    
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: LED_out = 7'b0000001; // "0"     
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5" 
        4'b0110: LED_out = 7'b0100000; // "6" 
        4'b0111: LED_out = 7'b0001111; // "7" 
        4'b1000: LED_out = 7'b0000000; // "8"     
        4'b1001: LED_out = 7'b0000100; // "9" 
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
    

    
 endmodule