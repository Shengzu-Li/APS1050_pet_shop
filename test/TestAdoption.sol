pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
// The address of the adoption contract to be tested
 Adoption adoption = Adoption(DeployedAddresses.Adoption());

// The id of the pet that will be used for testing
 uint expectedPetId = 8;

//The expected owner of adopted pet is this contract
 address expectedAdopter = address(this);

// Testing the adopt() function
function testUserCanAdoptPet() public {
  uint returnedId = adoption.adopt(expectedPetId);

  Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match what is returned.");
}

// Testing the register() function
function testUserCanRegisterPet() public {
  uint returnedId = adoption.register("Dabao", "Tugou", 4, "Toronto, ON", expectedPetId);

  Assert.equal(returnedId, expectedPetId, "Register of the expected pet should match what is returned.");
}

// Testing the returnPet() function
function testUserCanReturnPet() public {
  uint returnedId = adoption.returnPet(expectedPetId);

  Assert.equal(returnedId, expectedPetId, "Return of the expected pet should match what is returned.");
}

// Testing the getOwnerOfPet() function
function testUserCanGetOwnerOfPet() public {
  adoption.adopt(expectedPetId);
  address adopter = adoption.getOwnerOfPet(expectedPetId);
  
  Assert.equal(adopter, expectedAdopter, "Return of the expected pet should match what is returned.");
}

// Testing the getTotalPetsAdopted() function
function testUserCanGetTotalPetsAdopted() public {
  uint expectedCount = 1;
  uint count = adoption.getTotalPetsAdopted();
  
  Assert.equal(count, expectedCount, "Return of the expected pet should match what is returned.");
}

// Testing retrieval of a single pet's owner
function testGetAdopterAddressByPetId() public {
  address adopter = adoption.adopters(expectedPetId);

  Assert.equal(adopter, expectedAdopter, "Owner of the expected pet should be this contract");
}

// Testing retrieval of all pet owners
function testGetAdopterAddressByPetIdInArray() public {
  // Store adopters in memory rather than contract's storage
  address[16] memory adopters = adoption.getAdopters();

  Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract");
}

// Testing retrieval of most adopted breed
function testGetMostAdoptedBreed() public {
  bytes32 expectedBreed = "";
  bytes32 breed = adoption.getMostAdoptedBreed();

  Assert.equal(breed, expectedBreed, "Return of the expected pet breed should match what is returned.");
}


}

