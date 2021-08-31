pragma solidity ^0.5.0;

// lvl 2: tiered split
contract TieredProfitSplitter {
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob
	

    constructor(address payable _one, address payable _two, address payable _three) public payable{
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
		//require(msg.value < 100,"Not enough profit to distribute");
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

		amount = points * 60;
		//transfer 60% to CEO
		employee_one.transfer(amount);
		//update the total amount distributed so far
		total = total + amount;
		amount = points * 25;
		//Transfer 25% to CTO
		employee_two.transfer(amount);
		//update the total amount distributed so far
		total = total + amount;
		//Transfer 15% to Bob
		amount = points * 15;
		//Update the total amount distributed so far
		employee_two.transfer(amount);
		//Total should now contain the total amount distributed so far.
		total = total + amount;
        employee_one.transfer(msg.value - total); // ceo gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}
