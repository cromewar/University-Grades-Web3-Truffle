const grades = artifacts.require("Grades");

contract("Grades", (accounts) => {
  it("1.Function: avaluate(string _assesement, string memory _studentId, uint _grade)", async () => {
    // deployed smart contract
    let instance = await grades.deployed();
    //call to evaluate method
    const tx1 = await instance.evaluate("Math", "1234x", 9, {
      from: accounts[0],
    });
    const tx2 = await instance.evaluate("Chemestry", "1234x", 7, {
      from: accounts[0],
    });
    // print the tx's
    console.log(tx1);
    console.log(tx2);
    // See the grades into the blockchain
    const student_grade = await instance.viewGrades.call('Math', '1234x', {from: accounts[1]});
    console.log(student_grade);
  
    assert.equal(student_grade, 9);
  });
});
