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
    // string[] reviews;
    mapping(string => string[]) reviews;
    //events
    event reviewed_student(bytes32);
    event event_review(string);

    //Constructor
    constructor() {
        teacher = msg.sender;
    }

    // evaluate student
    function evaluate(string memory _assesement, string memory _studentId, uint256 _grade)
        public
        onlyOwner
    {
        //student identification hash
        bytes32 hash_studentId = keccak256(abi.encodePacked(_assesement, _studentId));
        // hash => studen Id
        StudentGrades[hash_studentId] = _grade;
        // emit event
        emit reviewed_student(hash_studentId);
    }

    //view the Grades
    function viewGrades(string memory _assesement, string memory _studentId)
        public
        view
        returns (uint256)
    {
        bytes32 hash_studentId = keccak256(abi.encodePacked(_assesement, _studentId));
        // return the grade
        uint256 studentGrade = StudentGrades[hash_studentId];
        return studentGrade;
    }

    // request grade reviews
    function askForReview(string memory _assesement, string memory _studentId) public {
        reviews[_assesement].push(_studentId);
        // store the student identity into an array
        emit event_review(_studentId);
    }

    // see request for reviewa
    function SeeReviews(string memory _assesement) public view onlyOwner returns (string[] memory) {
        return reviews[_assesement];
    }
}
