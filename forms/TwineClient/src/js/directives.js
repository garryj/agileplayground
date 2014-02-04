var directivesApp = angular.module('directives', [])

	.directive("design", function($timeout) {
		return {
			restrict: "A",
			link: function($scope, element) {		

				var mouseDown;
				var isInfoPanelPreferredVisible = false; // track user view preferences
				var alertTimer; // time alert
				

				/* Used when manipulating elements on stages */
				
				var mainStage;
				var rightStage;
				
				
				var displayElements = [];
				
				
				/* Used when dragging objects */
				
				var currentMouseStage; // Used for tracking of mouse coordinates across stages
				
				var dragDisplayElements = [];
				
				var eastDrag = false;
				var westDrag = false;
				var northDrag = false;
				var southDrag = false;
				
				var internalBoundsDisplayElements = [];
				var externalBoundsDisplayElement;

				
				initialise(); // Initialise all of the view


				/* Initialise */
				
				function initialise() {
					
					initialiseMainStage(); // initialise main canvas and stage
					
					initialiseRightStage(); // initialise right canvas and stage
					
					initialiseMouseTrack(); // initialise tracking
					
					extendEaselPrototypes(); // extend easeljs functionality
					
					initialiseViewPanels(); // add listeners to view panels
					
					addTickers(); // add tickers to both stages
					
				} // End of initialise

				
				
				/* Initialise main canvas and stage */
				
				function initialiseMainStage() {
					
					var mainCanvas = document.querySelector('#mainCanvas');
					
					mainCanvas.width  = window.innerWidth - 25;
					mainCanvas.height = window.innerHeight - 40;
					
					mainStage = new createjs.Stage(mainCanvas); //Create a stage by getting a reference to the canvas
					
					mainStage.enableMouseOver(20);  
					
				} // End of initialise main stage



				/* Initialise right canvas and stage */

				function initialiseRightStage() {
					
					var rightCanvas = document.querySelector('#rightCanvas');
					
					rightCanvas.width  = 333;
					rightCanvas.height = 1000;
					
					rightStage = new createjs.Stage(rightCanvas); //Create a stage by getting a reference to the canvas
					
					rightStage.enableMouseOver(20);
					
				} // End of initialise right stage
				

				
				/* Track mouse coordinates and stage */
	
				function initialiseMouseTrack() {
					
					/* Track coordinates across left stage */
					
					mainCanvas.onmousemove = function() {
						currentMouseStage = mainStage;
					};
					
					/*  Track coordinates across right stage */
					
					rightCanvas.onmousemove = function() {
						currentMouseStage = rightStage;
					};
				} // End of initialise mouse track
				
				
				
				/* Extend EaselJS functionality */
				
				function extendEaselPrototypes() {
					
					/* Dashed Line To */
					
					createjs.Graphics.prototype.dashedLineTo = function(x1, y1, x2, y2, dashLength) {
						
						this.moveTo(x1, y1);
						    
						var xDifference = x2 - x1;
						var yDifference = y2 - y1;
						
						var dashes = Math.floor(Math.sqrt((xDifference * xDifference) + (yDifference * yDifference)) / dashLength);
						
						var dashX = xDifference / dashes;
						var dashY = yDifference / dashes;
						    
						var q = 0;
						
						while (q++ < dashes) {
							x1 += dashX;
							y1 += dashY;
							this[q % 2 == 0 ? 'moveTo' : 'lineTo'](x1, y1);
						}
						
						this[q % 2 == 0 ? 'moveTo' : 'lineTo'](x2, y2); 
						
					} // End of dashedLineTo prototype
					
					
					
					/* Draw Dashed Rect */
						
					createjs.Graphics.prototype.drawDashedRect = function(rect, x1, y1, x2, y2, dashLen) {
						    
						rect.graphics.dashedLineTo(x1,y1,x2, y1, dashLen);
							
						rect.graphics.dashedLineTo(x2,y1,x2, y2, dashLen);
							
						rect.graphics.dashedLineTo(x1,y2, x2, y2, dashLen);
							
						rect.graphics.dashedLineTo(x1,y1,x1, y2, dashLen);
						
					} // End of draw dashed rect prototype
					
				} // End of extend easel js prototypes
				
				
				
				/* Manage panels */
				
				function initialiseViewPanels() {
					
					/* Right panel */
					
					var plus = document.querySelector('#plus');
					plus.onmouseover = function() {
						$scope.setIsRightPanelVisible(true); /**TODO - Only allow this action if mouse is not down **/
					};
					
					rightCanvas.onmouseout = function() {
						$scope.setIsRightPanelVisible(false);
					};
					
					
					/* Info panel */
					
					var info = document.querySelector('#info');
					info.onmousedown = function() {
						$scope.setIsInfoPanelPreferredVisible(true);
					};
					
				} // End of initialise view panels
				
				
				
				/* Add tickers to both stages */
				
				function addTickers() {
					
					/* Add ticker to main stage */
					
					createjs.Ticker.addEventListener("tick", mainStage);
					mainStage.update(); // update stage will render the next frame
					
					
					/* Add ticker to right stage */
					
					createjs.Ticker.addEventListener("tick", rightStage);
					rightStage.update(); // update stage will render the next frame
					
				} // End of add tickers
				
				

				/* Set element options */
				
				function setDisplayElementOptions() {
				
					/*
					var landingSpaceDrawing = drawLandingSpace(166.5, 200, rightStage);
					
					landingSpaceDrawing.addEventListener('mousedown', function() {
						
						
					});
					*/
					
				} // End of initialise right panel

				
				
				/* Add Element */
				
				$scope.addElement = function(element) {
					
					var displayElement = initialiseDisplayElement(element); // initialise a new container and add to stage
					
					displayElements.push(displayElement); // Add new container to display elements
					
					$scope.setDisplayElement(element); // Fill the new container
					
					mainStage.addChild(displayElement); // Add to stage
					
					
					/* Add listeners */
					
					/* Mouse Down */
					
					displayElement.on('mousedown', function() {
						
						mouseDown = 1;
						
						$scope.select(this.ID); // Call controller to retrieve data for this element and update the view
					
					}); // End of mouse down
					
					
					/* Mouse Move */
					
					displayElement.on('mouseover', function() {
						mainStage.addEventListener('stagemousemove', onMouseMove);
					});
					displayElement.on('mouseout', function() {
						mainStage.removeEventListener('stagemousemove', onMouseMove);
						
						document.body.style.cursor="default";
					});
					
					function onMouseMove() {
						
						if(!mouseDown) { // cursor must not change if dragging is taking place
						
							/* Calculate shape bounds */
							
							var leastX = displayElement.x - displayElement.regX;
							var mostX = displayElement.x + displayElement.regX;
							var leastY = displayElement.y - displayElement.regY;
							var mostY = displayElement.y + displayElement.regY;
							
							
							/* Calculate Drag Type */
							
							eastDrag = false;
							westDrag = false;
							northDrag = false;
							southDrag = false;
							
							if(((mostX - 5) <= currentMouseStage.mouseX) && (currentMouseStage.mouseX <= mostX)) { // East Drag

								eastDrag = true;
							}
							else if((leastX <= currentMouseStage.mouseX) && (currentMouseStage.mouseX <= (leastX + 5))) { // West Drag

								westDrag = true;
							}
							
							if((leastY <= currentMouseStage.mouseY) && (currentMouseStage.mouseY <= (leastY + 5))) { // North Drag

								northDrag = true;
							}
							
							else if(((mostY - 5) <= currentMouseStage.mouseY) && (currentMouseStage.mouseY <= mostY)) { // South Drag
								
								southDrag = true;
							}

							
							/* Update Cursor According To Drag Type */
							
							if(eastDrag && northDrag) { // North West
								
								document.body.style.cursor="ne-resize";
							}
							
							else if(westDrag && northDrag) { // North East
								
								document.body.style.cursor="nw-resize";
							}
							
							else if(eastDrag && southDrag) { // South West
								
								document.body.style.cursor="se-resize";
							}
							
							else if(westDrag && southDrag) { // South East
								
								document.body.style.cursor="sw-resize";
							}
							
							else if(eastDrag) { // East
								
								document.body.style.cursor="e-resize";
							}
							
							else if(westDrag) { // West
								
								document.body.style.cursor="w-resize";
							}
							
							else if(northDrag) { // North
								
								document.body.style.cursor="n-resize";
							}
							
							else if(southDrag) { // South
								
								document.body.style.cursor="s-resize";
							}
							
							else { // Move
								
								document.body.style.cursor="move";
							}
						} // End of if(mousedown)
						
					} // End of mouse move

					
					/* Press Move */
					
					displayElement.on('pressmove', function() {	
						
						var shouldRedraw = false;
						
						
						if((northDrag || southDrag) || (eastDrag || westDrag)) { // If user drags borders of the object
							
							if(northDrag) {
								
								if(dragNorth(this)) { // Extend the object north
									
									shouldRedraw = true;
								}
							}
							
							else if(southDrag) {
								
								if(dragSouth(this)) { // Extend the object south
									
									shouldRedraw = true;
								}
							}
							
							if(eastDrag) {
								
								if(dragEast(this)) { // Extend the object east
									
									shouldRedraw = true;
								}
							}
							
							else if(westDrag) {
								
								if(dragWest(this)) { // Extend the object west
									
									shouldRedraw = true;
								}
							}
							
							
						}
						else {

							drag(); // Drag entire display element
						}
						
						
						if(shouldRedraw) {
							
							if (!$scope.$$phase)
								$scope.$apply(); /**TODO - remove need for $$phase **/
							
							
							/* Redraw Element From Info Panel*/
							
							var element = new Element($scope.infoID, $scope.infoType, $scope.infoX, $scope.infoY, $scope.infoWidth, $scope.infoHeight, [], null);

							drawElementAt(element, $scope.infoX, $scope.infoY);
						}
						
					}); // End of press move
					
					
					/* Press Up */

					displayElement.on('pressup', function() {
						
						mouseDown = 0;
						
						if((northDrag || southDrag) || (eastDrag || westDrag)) { // Extension
							
							var element = new Element($scope.infoID, $scope.infoType, $scope.infoX, $scope.infoY, $scope.infoWidth, $scope.infoHeight, [], null);
							
							$scope.extendElement(element);
						}
						
						else { // Move
							
							var element = new Element($scope.infoID, $scope.infoType, $scope.infoX, $scope.infoY, $scope.infoWidth, $scope.infoHeight, [], null);
							
							$scope.moveElement(element);
						}
						
					}); // End of press up
					
				} // End of add element
				
				
				
				/* Initialise Display Element */
				
				function initialiseDisplayElement(element) {
					
					var container = new createjs.Container(); // Initialise container
					
					container.ID = element.ID;
					
					container.offset = null; // Used to calculate mouse offsets during drag
					
					
					/* Initialise internal shapes */
					
					switch(element.type) {
					
						/* Landing space */
					
						case "landing":
							
							/* Set minimum dimensions */
							
							container.minWidth = 30;
							container.minHeight = 30;
							
							
							/* Add shapes */
							
							var rectangle = new createjs.Shape();
							container.addChild(rectangle);
							
							var rectangle2 = new createjs.Shape();
							container.addChild(rectangle2);
							
							break;
							
							
						/* Object */
					
						case "object":
							
							/* Set minimum dimensions */
							
							container.minWidth = 40;
							container.minHeight = 40;
							
							
							/* Add shapes */
							
							var rectangle = new createjs.Shape();
							container.addChild(rectangle);
							break;
						
						
						/* Error */
							
						default:
							var rectangle = new createjs.Shape();
							container.addChild(rectangle);
							
					} // End of initialising internal shape instances
					
					
					return container;
					
				} // End of initialise container
				
				
				
				/* Drag North */
				
				function dragNorth(displayElement) {
					
					var rememberY = displayElement.y;
					var rememberRegY = displayElement.regY;
					
					var mostY = displayElement.y + displayElement.regY;
					
					var proposedHeight = mostY - currentMouseStage.mouseY;
					var proposedY = mostY - (proposedHeight / 2);
					
					displayElement.y = proposedY;
					displayElement.regY = proposedHeight / 2;
					
					
					if((displayElement.minWidth < proposedHeight) && isValidDragExtension(displayElement)) {

						$scope.infoHeight = proposedHeight;
						$scope.infoY = proposedY;
						
						return true; // should redraw
					}
					else {
						
						displayElement.y = rememberY;
						displayElement.regY = rememberRegY;
						
						return false; // do not redraw
					}
					
				} // End of drag north
				
				
				
				/* Drag South */
				
				function dragSouth(displayElement) {
					
					var rememberY = displayElement.y;
					var rememberRegY = displayElement.regY;
					
					var leastY = displayElement.y - displayElement.regY;
					
					var proposedHeight = currentMouseStage.mouseY - leastY;
					var proposedY = leastY + (proposedHeight / 2);
					
					displayElement.y = proposedY;
					displayElement.regY = proposedHeight / 2;
					
					
					if((displayElement.minWidth < proposedHeight) && isValidDragExtension(displayElement)) {

						$scope.infoHeight = proposedHeight;
						$scope.infoY = proposedY;
						
						return true; // should redraw
					}
					else {
						
						displayElement.y = rememberY;
						displayElement.regY = rememberRegY;
						
						return false; // do not redraw
					}
					
				} // End of drag south
				
				
				
				/* Drag East */
				
				function dragEast(displayElement) {
					
					var rememberX = displayElement.x;
					var rememberRegX = displayElement.regX;
					
					var leastX = displayElement.x - displayElement.regX;
					
					var proposedWidth = currentMouseStage.mouseX - leastX;
					var proposedX = leastX + (proposedWidth / 2);
					
					displayElement.x = proposedX;
					displayElement.regX = proposedWidth / 2;
					
					
					if((displayElement.minWidth < proposedWidth) && isValidDragExtension(displayElement)) {

						$scope.infoWidth = proposedWidth;
						$scope.infoX = proposedX;
						
						return true; // should redraw
					}
					else {
						
						displayElement.x = rememberX;
						displayElement.regX = rememberRegX;
						
						return false; // do not redraw
					}
					
				} // End of drag east
				
				
				
				/* Drag West */
				
				function dragWest(displayElement) {
					
					var rememberX = displayElement.x;
					var rememberRegX = displayElement.regX;
					
					var mostX = displayElement.x + displayElement.regX;
					
					var proposedWidth = mostX - currentMouseStage.mouseX;
					var proposedX = mostX - (proposedWidth / 2);
					
					displayElement.x = proposedX;
					displayElement.regX = proposedWidth / 2;
					
					
					if((displayElement.minWidth < proposedWidth) && isValidDragExtension(displayElement)) {

						$scope.infoWidth = proposedWidth;
						$scope.infoX = proposedX;
						
						return true; // should redraw
					}
					else {
						
						displayElement.x = rememberX;
						displayElement.regX = rememberRegX;
						
						return false; // do not redraw
					}
					
				} // End of drag west
				
				
				
				/* Is Valid Drag Extension */
				
				function isValidDragExtension(displayElement) {
					
					/* Ensure display element is still contained within parent display element */
					
					if(isWithin(displayElement, externalBoundsDisplayElement)) {

						/* Check if display element collides with sibling display elements */
						
						for(var i = 0; i < internalBoundsDisplayElements.length; i++) {
							
							if((displayElement.ID != internalBoundsDisplayElements[i].ID) && isCollision(displayElement, internalBoundsDisplayElements[i])) {

								return false; // New dimensions have made display element collide with another
							}
						}
						
						
						/* Ensure parent display element doesn't make its child display elements invalid */
						
						if(displayElement.type == "landing") {
							
							for(var i = 1; i < dragDisplayElements.length; i++) {
								
								if(!isWithin(dragDisplayElements[i], displayElement)) {
									
									return false; // New dimensions have made child display element invalid
								}
							}
						}
					}
					else {
						return false; // New dimensions are no longer contained within parent display element
					}
					
					return true; // New dimensions are valid
					
				} // End of is valid drag extension
				
				
				
				/* Is Collision */
				
				function isCollision(displayElement, otherDisplayElement) {
					
					var displayElementLeastX = displayElement.x - displayElement.regX;
					var displayElementMostX = displayElement.x + displayElement.regX;
					var displayElementLeastY = displayElement.y - displayElement.regY;
					var displayElementMostY = displayElement.y + displayElement.regY;
							
					var collisionLeastX = otherDisplayElement.x - otherDisplayElement.regX;
					var collisionMostX = otherDisplayElement.x + otherDisplayElement.regX;
					var collisionLeastY = otherDisplayElement.y - otherDisplayElement.regY;
					var collisionMostY = otherDisplayElement.y + otherDisplayElement.regY;
							
					if ((displayElementLeastX < collisionMostX)
						&& (displayElementMostX > collisionLeastX)
						&& (displayElementLeastY < collisionMostY)
						&& (displayElementMostY > collisionLeastY)) {

						return true; // collision detected
					}
					
					return false; // no collision detected
					
				} // End of is collision
				
				
				
				/* Is Within */
				
				function isWithin(displayElement, otherDisplayElement) {
						
					/* Calculate display element bounds */
						
					var elementLeastX = displayElement.x - displayElement.regX;
					var elementMostX = displayElement.x + displayElement.regX;
					var elementLeastY = displayElement.y - displayElement.regY;
					var elementMostY = displayElement.y + displayElement.regY;
						
						
					/* Calculate other display element bounds */
						
					var otherElementLeastX = otherDisplayElement.x - otherDisplayElement.regX;
					var otherElementMostX = otherDisplayElement.x + otherDisplayElement.regX;
					var otherElementLeastY = otherDisplayElement.y - otherDisplayElement.regY;
					var otherElementMostY = otherDisplayElement.y + otherDisplayElement.regY;
					
					
					/* If element is within other element */
						
					if((elementMostX < otherElementMostX)
						&& (otherElementLeastX < elementLeastX)
						&& (elementMostY < otherElementMostY)
						&& (otherElementLeastY < elementLeastY)) {

						return true; // Is within
					}
					
					return false; // is not within
					
				} // End of is within
				
				
				
				/* Drag */
				
				function drag() {
					
					/* Move all drag display elements to new coordinates */
					
					for(var i = 0; i < dragDisplayElements.length; i++) {
						
						/* Switch stage if necessary */
						
                		if((dragDisplayElements[i].getStage() == rightStage) && (currentMouseStage == mainStage)) {
                			
    						rightStage.removeChild(dragDisplayElements[i]);
    						mainStage.addChild(dragDisplayElements[i]);
    					}
                		
                		
                		/* Update x,y coordinates */
                		
                		dragDisplayElements[i].x = currentMouseStage.mouseX + dragDisplayElements[i].offset.x;
                		dragDisplayElements[i].y = currentMouseStage.mouseY + dragDisplayElements[i].offset.y;
                	}
					
					
					/* Update info panel */
					
					$scope.infoX = dragDisplayElements[0].x;
					$scope.infoY = dragDisplayElements[0].y;
					
				} // End of drag
				
				
				
				/* Set Display Element */
				
				$scope.setDisplayElement = function(element) {

					/* Convert relative x coordinate to actual x coordinate */
					
					var relativeX = 0;
					var relativeY = 0;
					
					
					/* Scroll through parent objects and add relative x,y coordinates */
					
					var parentElement = element.parent;

					while(parentElement != null) {
						
						relativeX += parentElement.x - (parentElement.width / 2);
						relativeY += parentElement.y - (parentElement.height / 2);
						
						parentElement = parentElement.parent;
					}

					var x = relativeX + element.x;
					var y = relativeY + element.y;
					
					drawElementAt(element, x, y);
					
				} // End of set display element
				
				
				
				/* Set Info Panel */
				
				$scope.setInfoPanel = function(element) {
					
					$scope.infoID = element.ID;
					
					var container = displayElements[element.ID];
					$scope.infoX = container.x;
					$scope.infoY = container.y;
					
					$scope.infoRelativeX = element.x;
					$scope.infoRelativeY = element.y;
					
					$scope.infoType = element.type;
					
					$scope.infoWidth = element.width;
					$scope.infoHeight = element.height;
					
					if (!$scope.$$phase)
		        		$scope.$apply(); /**TODO - remove need for $$phase **/
					
				} // End of set info panel
				
				
				
				/* Set Drag */
				
				$scope.setDrag = function(dragElements, externalBoundElement, internalBoundElements)  {
					
					/* Set Draggable Display Elements */
					
					dragDisplayElements = []; // Clear existing drag display elements
					
					for(var i = 0; i < dragElements.length; i++) {
						
						var displayElement = displayElements[dragElements[i].ID]; // Get display element for drag element
						
						displayElement.offset = {x: displayElement.x - currentMouseStage.mouseX, y: displayElement.y - currentMouseStage.mouseY}; // Set mouse offsets for each object						
						
						dragDisplayElements.push(displayElement); // Add display element to drag display elements
						
						mainStage.setChildIndex(displayElement, mainStage.getNumChildren() - 1); // Set z index of drag display elements to be at forefront of the view
					}
					
					
					/* Set External Bound Display Element */
					
					externalBoundsDisplayElement = displayElements[externalBoundElement.ID]; // set parent display element
					
					
					/* Set Internal Bound Display Elements */
					
					internalBoundsDisplayElements = []; // Clear existing internal display elements
					
					for(var i = 0; i < internalBoundElements.length; i++) {
						
						var displayElement = displayElements[internalBoundElements[i].ID]; // Get display element for internal bounds display elements
						
						internalBoundsDisplayElements.push(displayElement); // Add display element to internal display elements
					}
					
				} // End of set drag
				
				
				
				/* Draw Element At */
				
				function drawElementAt(element, x, y) {
					
					var container = displayElements[element.ID];

					
					/* Move Container */
					
					container.x = x;
					container.y = y;
					
					
					/* Update Dimensions */
					
					container.regX = element.width / 2;
					container.regY = element.height / 2;
					
					
					/* Clear existing container contents */
					
					for(var i = 0; i < container.children.length; i++) {
						container.children[i].graphics.clear();
					}
					
					
					/* Draw */
					
					container.type = element.type;
					
					switch(element.type) {
					
						/* Draw a landing space */
					
						case "landing":
							container.children[0].graphics.beginStroke("#808080");
							container.children[0].graphics.setStrokeStyle(3);
							container.children[0].graphics.drawDashedRect(container.children[0], 0, 0, element.width, element.height, 2);
							container.children[1].graphics.beginFill("white").drawRect(0, 0, element.width, element.height);
							break;
					
						
						/* Draw an object */
							
						case "object":
							container.children[0].graphics.beginFill("blue").drawRect(0, 0, element.width, element.height);
							break;
							
							
						/* Draw an error */
							
						default:
							container.children[0].graphics.beginFill("red").drawRect(0, 0, element.width, element.height);
					}
					
				} // End of draw element at
				

				
		        /* Set Alert Message */
				
		        $scope.setAlert = function(message) {
		        		
		        	$scope.isAlertVisible = true;
		        	
		        	$scope.message = message;
			        
		        	if (!$scope.$$phase)
		        		$scope.$apply(); /**TODO - remove need for $$phase **/
		        		
			        	
			        alertTimer = $timeout(function() {
	 
			        	$scope.isAlertVisible = false;
			        	
			        	if (!$scope.$$phase)
			        		$scope.$apply(); /**TODO - remove need for $$phase **/
				        	
				        $timeout.cancel(alertTimer);
			        			
			        }, 3000);
		        	
		        }; // End of set alert message
		        
		        
		        
		        /* Set Is Info Panel Visible */
				
				$scope.setIsInfoPanelVisible = function(isVisible) {
					
					$scope.isInfoPanelVisible = isVisible;
					
					if (!$scope.$$phase)
						$scope.$apply(); /**TODO - remove need for $$phase **/
					
				}; // End of set is info panel visible
				
				
				
				/* Set Is Info Panel Preferred Visible */
				
				$scope.setIsInfoPanelPreferredVisible = function(isPreferredVisible) {
					
					isInfoPanelPreferredVisible = isPreferredVisible;
					
					if(!$scope.isRightPanelVisible) {
						
						$scope.setIsInfoPanelVisible(isPreferredVisible);
					}
					
					if (!$scope.$$phase)
						$scope.$apply(); /**TODO - remove need for $$phase **/
					
				}; // End of set is info panel preferred visible
				
		        
		        
		        /* Set is right panel visible */
		        
				$scope.setIsRightPanelVisible = function(isVisible) {
					
					$scope.isRightPanelVisible = isVisible;
					
					if(isVisible) {
						
						$scope.setIsInfoPanelVisible(false);
					}
					else if (isInfoPanelPreferredVisible) {
						
						$scope.setIsInfoPanelVisible(true);
					}
					
					if (!$scope.$$phase)
						$scope.$apply(); /**TODO - remove need for $$phase **/
					
				}; // End of set is right panel visible
				
			} // End of link function
		}; // End of directive
	}); // End of module


