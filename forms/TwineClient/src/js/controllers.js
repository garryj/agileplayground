var servicesApp = angular.module('controllers', [])

	.controller("controller", function($scope, $location, $timeout, model) {
		
		/* Set Route */
		
		$scope.setRoute = function(route){
			
            $location.path(route);
            
        }; // End of set route
		
		
		initialise(); // initialise controller
		
		
		/* Initialise */
		
		function initialise() {
			
			$scope.title = "My Project";

		}; // End of initialise
		


		/* Initialise Elements */
		
		var initialiseElements = $timeout(function() {

			var elements = model.getElements();
			
			for(var i = 0; i < elements.length; i++) {

				$scope.addElement(elements[i]);
			}

		},300);
		
		
		
		/* Select */
		
		$scope.select = function(ID) {
			
			var selectedElement = model.getElementByID(ID);

			$scope.setInfoPanel(selectedElement);
			
			var elementTree = flattenChildren(selectedElement, []);
			
			var selectedElementParent = selectedElement.parent;
			
			$scope.setDrag(elementTree, selectedElementParent, selectedElementParent.children);
			
			alert(1);
			
		} // End of select
		
		
		
		/* Flatten Children */
		
		function flattenChildren(element, flattenedArray) {
			
			flattenedArray.push(element);
			
			if(element.children.length != 0) {
				
				for(var i=0; i < element.children.length; i++) {
					flattenedArray.concat(flattenChildren(element.children[i], flattenedArray));
				}
			}
			
			return flattenedArray;
			
		} // End of flatten children
		
		
		
		/* Extend Element */
		
		$scope.extendElement = function (modifiedElement) {
			
			var modelledElement = model.getElementByID(modifiedElement.ID); // get model representation
			
			
			/* Convert x y coordinates of modified element from absolute to relative */
			
			var parentElement = modelledElement.parent.parent; // As isWithin uses absolute positioning, ignore relativity to first parent
			
			while(parentElement != null) {
				
				modifiedElement.x -= parentElement.x - (parentElement.width / 2);
				modifiedElement.y -= parentElement.y - (parentElement.height / 2);
				
				parentElement = parentElement.parent;
			}
			
			if((30 < modifiedElement.width) && (30 < modifiedElement.height) && isWithin(modifiedElement, modelledElement.parent)) {
				
				/* Finish converting coordinates to relative x,y */
				
				modifiedElement.x -=  modelledElement.parent.x - ( modelledElement.parent.width / 2);
				modifiedElement.y -=  modelledElement.parent.y - ( modelledElement.parent.height / 2);
				
				/* Update modelled element */
				
				modelledElement.x = modifiedElement.x;
				modelledElement.y = modifiedElement.y;
				modelledElement.width = modifiedElement.width;
				modelledElement.height = modifiedElement.height;
			}
			else {
				
				$scope.setDisplayElement(modelledElement);
				
				$scope.setAlert("Object cannot be dragged here.");
			}
			
		} // End of extend element
		
		
		
		/* Move Element */
		
		$scope.moveElement = function(modifiedElement) {
			
			var modelledElement = model.getElementByID(modifiedElement.ID); // get model representation
        	
        	var potentialParent = model.getElementByID(0); // get main parent element
    		
			
			/* If proposed position is within the main space */
			
			if(isWithin(modifiedElement, potentialParent)) {
        		
        		/* Reduce x,y coordinates to be relative to parent */
        		
        		modifiedElement.x -= potentialParent.x - (potentialParent.width / 2);
        		modifiedElement.y -= potentialParent.y - (potentialParent.height / 2);
        		
        		
        		var isValidMove = true;
        		var i = 0; // Used to iterate through child elements
        		
        		while(isValidMove && (i < potentialParent.children.length)) { // Iterate through elements
        				
        			if((potentialParent.children[i].type == "landing") && isWithin(modifiedElement, potentialParent.children[i])) { // If modified element is now within another element
	            		
        				potentialParent = potentialParent.children[i]; // The modified element's parent is assigned

	            		
	            		/* Reduce x,y coordinates to be relative to parent */
	            			
	            		modifiedElement.x -= potentialParent.x - (potentialParent.width / 2);
	                	modifiedElement.y -= potentialParent.y - (potentialParent.height / 2);
	                	
	                	
	                	/* Begin iterations through child elements of new parent container */
	                	
	            		i = 0;
	            		continue;
        			}
        			
	            	else if (isCollision(modifiedElement, potentialParent.children[i])) { // If modified element overlaps another element

	            		isValidMove = false;
	            	}
            			
        			i++; // Iterate to next child element
        		}
        	}
        	else {
        		
        		isValidMove = false;
        	}
        	
        	if(isValidMove) {

        		model.getElementByID(modelledElement.parent.ID).removeChild(modelledElement); // Detach from originally modelled parent
        		
        		
        		/* Add new modelled parent */
        		
        		var modelledParentElement = model.getElementByID(potentialParent.ID)
        		
    			modelledParentElement.addChild(modelledElement);
    			
    			modelledElement.setParent(modelledParentElement);

    			modelledElement.x = modifiedElement.x;
    			modelledElement.y = modifiedElement.y;
    			modelledElement.width = modifiedElement.width;
    			modelledElement.height = modifiedElement.height;
    			
				model.setElement(modelledElement); // Update model
			}
        	else {
        		
        		/* Move all elements that were dagged back to their original positions */
        		
        		var dragElements = flattenChildren(modelledElement, []);
        		
        		for(var i = 0; i < dragElements.length; i++) {
        			
        			$scope.setDisplayElement(dragElements[i]);
        		}
        		
        		
        		$scope.setAlert("Object cannot be placed here.");
        	}
        	
        	$scope.setInfoPanel(modelledElement); // Update the view with the originally modelled element
        	
		} // End of move object
		
		
		
		/* Is Within */
		
		function isWithin(element, otherElement) {
			
			if(element.ID != otherElement.ID) {
				
				/* Calculate element bounds */
				
				var elementLeastX = element.x - (element.width / 2);
				var elementMostX = element.x + (element.width / 2);
				var elementLeastY = element.y - (element.height / 2);
				var elementMostY = element.y + (element.height / 2);
				
				
				/* Calculate other element bounds */
				
				var otherElementLeastX = otherElement.x - (otherElement.width / 2);
				var otherElementMostX = otherElement.x + (otherElement.width / 2);
				var otherElementLeastY = otherElement.y - (otherElement.height / 2);
				var otherElementMostY = otherElement.y + (otherElement.height / 2);
				
				
				/* If element is within other element */
				
				if((elementMostX < otherElementMostX)
					&& (otherElementLeastX < elementLeastX)
					&& (elementMostY < otherElementMostY)
					&& (otherElementLeastY < elementLeastY)) {
					
					return true; // Is within
				}
			}
			
			return false; // Is not within
			
		} // End of is within
		
		
		
		/* Is Collision */
		
		function isCollision(element, otherElement) {					
				
			if(element.ID != otherElement.ID) {
				
				/* Calculate element bounds */
				
				var elementLeastX = element.x - (element.width / 2);
				var elementMostX = element.x + (element.width / 2);
				var elementLeastY = element.y - (element.height / 2);
				var elementMostY = element.y + (element.height / 2);
				
				
				/* Calculate other element bounds */
				
				var otherElementLeastX = otherElement.x - (otherElement.width / 2);
				var otherElementMostX = otherElement.x + (otherElement.width / 2);
				var otherElementLeastY = otherElement.y - (otherElement.height / 2);
				var otherElementMostY = otherElement.y + (otherElement.height / 2);
				
				
				/* If elements intersect */
				
				if ((elementLeastX < otherElementMostX)
					&& (elementMostX > otherElementLeastX)
					&& (elementLeastY < otherElementMostY)
					&& (elementMostY > otherElementLeastY)) {
					
					return true; // Has collided
				}
			}
			
			return false; // No collision
			
		} // End of is collision
		
	}); // End of controller