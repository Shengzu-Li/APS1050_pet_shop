pragma solidity ^0.5.0;

//Adoption, FindPetOwenr and track how many custumers(address) adopted, and how many pets adopted
//9. a way of keeping track of which pet belongs to which owner 
//12. a way of keeping track of how many custumers have been served and how many pets adopted

contract Adoption {
  address[16] public adopters;
  //owner feature 
  //find address
  mapping(uint => address) public petToOwner; 
  // Record our pet shop served how many custumers

  uint public countPetAdopted;

  // Adopting a pet
  function adopt(uint petId) public returns (uint) {
    require(petId >= 0 && petId <= 15);
    // check the pet is notAdopted (owner feature)
    require(adopters[petId] == address(0));
    //every address only once 
    adopters[petId] = msg.sender;

    //Record the owner and pet owner feature）
    petToOwner[petId] = msg.sender;

    countPetAdopted++;

    return petId;
  }

  // Retrieving the adopters
  function getAdopters() public view returns (address[16] memory) {
    return adopters;
  }

  //9. feature for find Pet owner
  // Retrieving the owner of a pet
  function getOwnerOfPet(uint petId) public view returns (address) {
    require(petId >= 0 && petId <= 15);
    return (petToOwner[petId]);
  }  

  //12.track how many custumers(address) adopted, and how many pets adopted
  //two function getTotalCustumers and getTotalPetsAdopted
  function getTotalPetsAdopted() public view returns (uint) {
    return countPetAdopted;
  }

}



