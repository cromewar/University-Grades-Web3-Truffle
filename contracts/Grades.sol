//SPDX-License-Identifier: MIT

pragma solidity >=0.6.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Grades is Ownable {
    // Teacher address
    address public teacher;
    //mapping
    mapping(bytes32 => uint256) public StudentGrades;
    //array
    string[] reviews;
    //events
    event reviewed_student(bytes32);
    event event_review(string);

    //Constructor
    constructor() {
        teacher = msg.sender;
    }

    // evaluate student
    function evaluate(string memory _studentId, uint256 _grade)
        public
        onlyOwner
    {
        //student identification hash
        bytes32 hash_studentId = keccak256(abi.encodePacked(_studentId));
        // hash => studen Id
        StudentGrades[hash_studentId] = _grade;
        // emit event
        emit reviewed_student(hash_studentId);
    }

    //view the Grades
    function viewGrades(string memory _studentId)
        public
        view
        returns (uint256)
    {
        bytes32 hash_studentId = keccak256(abi.encodePacked(_studentId));
        // return the grade
        uint256 studentGrade = StudentGrades[hash_studentId];
        return studentGrade;
    }

    // request grade reviews
    function askForReview(string memory _studentId) public {
        reviews.push(_studentId);
        // store the student identity into an array
        emit event_review(_studentId);
    }

    // see request for reviewa
    function SeeReviews() public view onlyOwner returns (string[] memory) {
        return reviews;
    }
}
