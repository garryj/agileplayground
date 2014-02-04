var servicesApp = angular.module('services', [])

	.config(function($httpProvider){
		
		$httpProvider.defaults.useXDomain = true;
		delete $httpProvider.defaults.headers.common['X-Requested-With'];
		
	})

	.factory('model', function() {
		
		/*$http({
			url: 'http://localhost:8081/controller/TestServlet',
			method: "POST",
			data: "thread",
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).success(function (data, status, headers, config) {
			$scope.parsedData = data;
			alert("RECEIVED SUCCESS: " + $scope.parsedData);
			
		}).error(function (data, status, headers, config) {
			$scope.parsedData = data;
			alert("FAIL");
			
		});*/
		
		var elements = [];
		
		
		var elCanvas = new Element(0, "landing", 700, 400, 500, 600, [], null);
		
		elements.push(elCanvas);
		
		
		var element2 = new Element(1, "landing", 200, 200, 175, 150, [], elCanvas);
		
		elCanvas.addChild(element2);
		
		elements.push(element2);
		
		
		var element3 = new Element(2, "object", 100, 100, 70, 50, [], element2);
		
		element2.addChild(element3);
		
		elements.push(element3);
		
		
		var element4 = new Element(3, "object", 400, 100, 70, 50, [], elCanvas);
		
		elCanvas.addChild(element4);
		
		elements.push(element4);
		
		
		
		var element5 = new Element(4, "landing", 400, 500, 100, 100, [], elCanvas);
		
		elCanvas.addChild(element5);
		
		elements.push(element5);
		
		

		
		return {
			
			getElementByID : function(ID) {
				
				for(var i = 0; i < elements.length; i++) {
					
					if(elements[i].ID == ID) {

						return elements[i];
					}
				}
				
				return null;
			},
		
			getElements : function() {
				
				return elements;
			},
			
			
			
			
			
			
			
			setElement : function(element) {
				
				for(var i = 0; i < elements.length; i++) {
					
					if(elements[i].ID == element.ID) {

						elements[i] = element;
					}
				}
			}
		}
	});