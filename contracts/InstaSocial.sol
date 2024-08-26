// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26; // It's a good practice to specify the version of Solidity used in your contract

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract AjmeetBixbiSocial is Ownable, ReentrancyGuard  {
    uint256 public balance; // The state variable 'balance' needs to be declared with 'public' or 'private'.
    
    event AjmeetPostCreated(address indexed user, string content, uint256 timestamp);
    event AjmeetPostLiked(address indexed user, uint256 postId, uint256 timestamp);

    struct Post  {
        address user;
        string content;
        uint256 timestamp;
        uint256 likes;
     }

    Post[] public posts; // Public array of type 'Post' named 'posts' declared.

    constructor() Ownable(msg.sender) { 
        balance = 0;
    }

    function getBalance() public view returns (uint256) {
        return balance;
     }
     
     // The modifier 'whenNotPaused' is not defined, you may need to create it.
     function createPost(string memory content) public /*whenNotPaused*/  {
         posts.push(Post({ user: msg.sender, content: content, timestamp: block.timestamp, likes: 0 }));
         emit AjmeetPostCreated(msg.sender, content, block.timestamp);
     }
     
     function likePost(uint256 postId) public /*whenNotPaused*/ {
         require(postId < posts.length, "Post does not exist");
         posts[postId].likes += 1; // Direct addition is safe in newer Solidity versions
         emit AjmeetPostLiked(msg.sender, postId, block.timestamp);
     }
     
    function getPosts() public view returns (Post[] memory) {
        return posts;
    } 
}
