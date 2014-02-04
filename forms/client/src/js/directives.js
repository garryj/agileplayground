var directivesApp = angular.module('directives', [])

	.directive("designCanvas", function(){
		return {
			restrict: "A",
			link: function($scope, element){
				
				/* Initialise main canvas and stage */
		    	
				var mainCanvas = element.find('canvas')[0];
				
				mainCanvas.width  = window.innerWidth;
				mainCanvas.height = window.innerHeight - 40;
				
				var mainStage = new createjs.Stage(mainCanvas); //Create a stage by getting a reference to the canvas
	
				
				/* Initialise right canvas and stage */
				
				var rightCanvas = element.find('canvas')[1];
				
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
	
				
				/* Initialise main stage objects */
				
				//var text = new createjs.Text($scope.title, "20px Arial", "#ff7700");
				//text.x = text.y = 100;
			
				var rect = new createjs.Shape();
				rect.graphics.beginFill("grey").drawRect(0, 0, 500, 200);
				rect.x = rect.y = 200;
	
				mainStage.addChild(rect);
				
				//Update stage will render next frame
				createjs.Ticker.addListener(mainStage);
				mainStage.update();
	
				
				/* Initialise right stage objects */
		
				var rect = new createjs.Shape();
				rect.graphics.beginFill("red").drawRect(0, 0, 313, 75);
	
				var container = new createjs.Container(); // Initialise container
				container.x = 166.5;
				container.y = 47.5;
				container.regX = 156.5;
				container.regY = 37.5;
				container.addChild(rect);
				rightStage.addChild(container);
	
				container.onPress = function(evt) {
					
					var offset = {x: evt.target.x - evt.stageX, y: evt.target.y - evt.stageY};
					
					evt.onMouseMove = function() {
		
						if(container.getStage() != mouse.currentStage) {
							container.getStage().removeChild(evt);
							mouse.currentStage.addChild(container);
						}
						
						evt.target.x = mouse.stageX + offset.x;
						evt.target.y = mouse.stageY + offset.y;
					}
				}
				
				//Update stage will render next frame
				createjs.Ticker.addListener(rightStage);
				rightStage.update();
			}
		};
	});