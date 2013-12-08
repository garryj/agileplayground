var directivesApp = angular.module('directives', [])

	.directive("designCanvas", function(){
		return {
			restrict: "A",
			link: function($scope, element){
				
				/* Initialise main canvas and stage */
				
				var mainCanvas = document.querySelector('#mainCanvas');
				
				mainCanvas.width  = window.innerWidth - 25;
				mainCanvas.height = window.innerHeight - 40;
				
				var mainStage = new createjs.Stage(mainCanvas); //Create a stage by getting a reference to the canvas
	
				
				/* Initialise right canvas and stage */
				
				var rightCanvas = document.querySelector('#rightCanvas');
				
				rightCanvas.width  = 333;
				rightCanvas.height = 1000;
				
				var rightStage = new createjs.Stage(rightCanvas); //Create a stage by getting a reference to the canvas

				
				/* Track mouse coordinates and stage */
	
				var mouse = {currentStage: mainStage, stageX: 0, stageY: 0};
				
				mainCanvas.onmousemove = function() {
					mouse.currentStage = mainStage;
					mouse.stageX = mainStage.mouseX;
					mouse.stageY = mainStage.mouseY;
				}
				
				rightCanvas.onmousemove = function() {
					mouse.currentStage = rightStage;
					mouse.stageX = rightStage.mouseX;
					mouse.stageY = rightStage.mouseY;
				}
				
				
				/* Manage panels */
				
				var plus = document.querySelector('#plus');
				plus.onmouseover = function() {
					$scope.setIsRightPanelVisible(true);
				}
				
				rightCanvas.onmouseout = function() {
					$scope.setIsRightPanelVisible(false);
				}
				
				var info = document.querySelector('#info');
				info.onmousedown = function() {
					$scope.setIsInfoPanelVisible(true);
				}
				
				
				/* Add landing spaces */
				
				var landingSpaces = [];
				
				var x = 500;
				var y = 200;
				
				for(var i = 0; i < 2; i++) {

					landingSpaces.push(initialiseLandingSpace(i, x, y));
					
					y += 175;
				}

				
				/* Add objects */
				
				var objects = [];
				
				var x = 166.5;
				var y = 47.5;
				
				for(var i = 0; i < 2; i++) {

					y += 100;
					
					objects.push(initialiseDraggable(i, x, y));
				}
				
				//Update stage will render next frame
				createjs.Ticker.addEventListener("tick", mainStage);
				mainStage.update();
				
				//Update stage will render next frame
				createjs.Ticker.addEventListener("tick", rightStage);
				rightStage.update();


				function initialiseLandingSpace(ID, x, y) {
					
					var rect = new createjs.Shape();
					rect.graphics.beginStroke("#C1272D");
					rect.graphics.setStrokeStyle(2); // 2 pixel
					rect.graphics.drawRect(0, 0, 400, 100);
					
					var container = new createjs.Container(); // Initialise container
					container.x = x;
					container.y = y;
					container.regX = 200;
					container.regY = 50;
					container.addChild(rect);
					
					container.ID = ID;
					
					mainStage.addChild(container);
					
					var rememberX;
					var rememberY;
					var rememberStage;
					var hasLanded;
					var offset;
					
					container.addEventListener('mousedown', function() {
						
						rememberX = container.x;
						rememberY = container.y;
						rememberStage = container.getStage();
						
						hasLanded = false;

						offset = {x: container.x - mouse.stageX, y: container.y - mouse.stageY};
					});
					
					
					container.addEventListener('pressmove', function() {
                    	
                    	if(container.getStage() != mouse.currentStage) {
                            	
                    		container.getStage().removeChild(container);
                    		mouse.currentStage.addChild(container);
                    	}
                            
                    	container.x = mouse.stageX + offset.x;
                    	container.y = mouse.stageY + offset.y;
                    	
                    	
                    	hasLanded = false;
                    	
                		/* Move into space if mouse is hovering over another object */
                		
                    	for (var i = 0; i < landingSpaces.length; i++) {
                    		
                    		var leastX = landingSpaces[i].x - landingSpaces[i].regX;
                    		var mostX = landingSpaces[i].x + landingSpaces[i].regX;
                    		
                    		var leastY = landingSpaces[i].y - landingSpaces[i].regY;
                    		var mostY = landingSpaces[i].y + landingSpaces[i].regY;
                    		
                    		if((landingSpaces[i] != container)
                    				&& (container.getStage() == landingSpaces[i].getStage())
                    				&& ((leastY < mouse.stageY) && (mouse.stageY < mostY))
                    				&& ((leastX < mouse.stageX) && (mouse.stageX < mostX))) {
                    			
                    			container.x = landingSpaces[i].x;
                    			container.y = landingSpaces[i].y;
                    			
                    			hasLanded = true;
                    		}
                    	}
					});
					
					
					container.addEventListener('pressup', function() {
						
						/* Detect collisions */
                    	
                    	var containerLeastX = container.x - container.regX;
                		var containerMostX = container.x + container.regX;
                		
                		var containerLeastY = container.y - container.regY;
                		var containerMostY = container.y + container.regY;


                		/* Detect collisions with other objects */
                		
                    	for (var i = 0; i < landingSpaces.length; i++) {
                    		
                    		if(landingSpaces[i] != container) {
                    			
                        		var leastX = landingSpaces[i].x - landingSpaces[i].regX;
                        		var mostX = landingSpaces[i].x + landingSpaces[i].regX;
                        		
                        		var leastY = landingSpaces[i].y - landingSpaces[i].regY;
                        		var mostY = landingSpaces[i].y + landingSpaces[i].regY;
                        		
                               	if((container.getStage() == landingSpaces[i].getStage())
                               			&& (((leastY <= containerLeastY) && (containerLeastY <= mostY))
                               					|| ((leastY <= containerMostY) && (containerMostY <= mostY)))
                               			&& (((leastX < containerLeastX) && (containerLeastX < mostX))
                               					|| ((leastX <= containerMostX) && (containerMostX <= mostX)))) {

    		                    	if(rememberStage != mouse.currentStage) {
    	                            	
    		                    		container.getStage().removeChild(container);
    		                    		mouse.currentStage.addChild(container);
    		                    		
    		                    		rememberX = 166.5;
    		    						rememberY = 100;
    		                    	}
    		                    
                               		container.x = rememberX;
    								container.y = rememberY;
    								
    								hasLanded = false;
                               	}
                    		}
                    	}
                    	
                    	if(hasLanded) {
                    		$scope.alert("Object landed.");
                    	}
                    	
                    	$scope.setInfoPanel(1);
					});
					
					return container;
				}


				function initialiseDraggable(ID, x, y) {

					var rect = new createjs.Shape();
					rect.graphics.beginFill("red").drawRect(0, 0, 313, 75);

					var container = new createjs.Container(); // Initialise container
					container.x = x;
					container.y = y;
					container.regX = 156.5;
					container.regY = 37.5;
					container.addChild(rect);

					container.ID = ID;

					rightStage.addChild(container);
					
					
					var rememberX;
					var rememberY;
					var rememberStage;
					var hasLanded;
					var offset;

					container.addEventListener('mousedown', function() {
						
						rememberX = container.x;
						rememberY = container.y;
						rememberStage = container.getStage();
						
						hasLanded = false;

						offset = {x: container.x - mouse.stageX, y: container.y - mouse.stageY};
					});
					
					
					container.addEventListener('pressmove', function() {
                    	
                    	if(container.getStage() != mouse.currentStage) {
                            	
                    		container.getStage().removeChild(container);
                    		mouse.currentStage.addChild(container);
                    	}
                            
                    	container.x = mouse.stageX + offset.x;
                    	container.y = mouse.stageY + offset.y;
                    	
                    	
                    	hasLanded = false;
                    	
                		/* Move into space if mouse is hovering over another object */
                		
                    	for (var i = 0; i < landingSpaces.length; i++) {
                    		
                    		var leastX = landingSpaces[i].x - landingSpaces[i].regX;
                    		var mostX = landingSpaces[i].x + landingSpaces[i].regX;
                    		
                    		var leastY = landingSpaces[i].y - landingSpaces[i].regY;
                    		var mostY = landingSpaces[i].y + landingSpaces[i].regY;
                    		
                    		if((container.getStage() == landingSpaces[i].getStage())
                    				&& ((leastY < mouse.stageY) && (mouse.stageY < mostY))
                    				&& ((leastX < mouse.stageX) && (mouse.stageX < mostX))) {
                    			
                    			container.x = landingSpaces[i].x;
                    			container.y = landingSpaces[i].y;
                    		}
                    	}
					});
					
					
					container.addEventListener('pressup', function() {
						
						/* Detect collisions */
                    	
                    	var containerLeastX = container.x - container.regX;
                		var containerMostX = container.x + container.regX;
                		
                		var containerLeastY = container.y - container.regY;
                		var containerMostY = container.y + container.regY;


                		/* Detect collisions with other objects */
                		
                    	for (var i = 0; i < objects.length; i++) {
                    		
                    		if(objects[i] != container) {
                    			
                        		var leastX = objects[i].x - objects[i].regX;
                        		var mostX = objects[i].x + objects[i].regX;
                        		
                        		var leastY = objects[i].y - objects[i].regY;
                        		var mostY = objects[i].y + objects[i].regY;
                        		
                               	if((container.getStage() == objects[i].getStage())
                               			&& (((leastY <= containerLeastY) && (containerLeastY <= mostY))
                               					|| ((leastY <= containerMostY) && (containerMostY <= mostY)))
                               			&& (((leastX < containerLeastX) && (containerLeastX < mostX))
                               					|| ((leastX <= containerMostX) && (containerMostX <= mostX)))) {

    		                    	if(rememberStage != mouse.currentStage) {
    	                            	
    		                    		container.getStage().removeChild(container);
    		                    		mouse.currentStage.addChild(container);
    		                    		
    		                    		rememberX = 166.5;
    		    						rememberY = 100;
    		                    	}
    		                    
                               		container.x = rememberX;
    								container.y = rememberY;
                               	}
                    		}
                    	}
                    	
                    	
                    	hasLanded = false;
                    	
                		/* Move into space if mouse is hovering over another object */
                		
                    	for (var i = 0; i < landingSpaces.length; i++) {
                    		
                    		var leastX = landingSpaces[i].x - landingSpaces[i].regX;
                    		var mostX = landingSpaces[i].x + landingSpaces[i].regX;
                    		
                    		var leastY = landingSpaces[i].y - landingSpaces[i].regY;
                    		var mostY = landingSpaces[i].y + landingSpaces[i].regY;
                    		
                    		if((container.getStage() == landingSpaces[i].getStage())
                    				&& ((leastY < mouse.stageY) && (mouse.stageY < mostY))
                    				&& ((leastX < mouse.stageX) && (mouse.stageX < mostX))) {
                    			
                    			container.x = landingSpaces[i].x;
                    			container.y = landingSpaces[i].y;
                    			
                    			hasLanded = true;
                    		}
                    	}
                    	
                    	if(hasLanded) {
                    		$scope.setAlert("Object landed.");
                    		$scope.setIsAlertVisible(true);
                    	}
                    	
                    	$scope.setInfoPanel(1);
					});
					
					return container;
					
				} // End of initialise object
			}
		};
	});