var servicesApp = angular.module('services', [])

	.config(function($httpProvider){
		
		$httpProvider.defaults.useXDomain = true;
		delete $httpProvider.defaults.headers.common['X-Requested-With'];
		
	})

	.factory('testService', function() {
		  var shinyNewServiceInstance;
		  
		  
			/*$http({
				url: 'http://localhost:8081/controller/TestServlet',
				method: "POST",
				data: "thread",
				headers: {'Content-Type': 'application/x-www-form-urlencoded'}
			}).success(function (data, status, headers, config) {
				$scope.parsedData = data;
				}).error(function (data, status, headers, config) {
					$scope.parsedData = data;
			});*/
		  
		  
		  
		  
		  //factory function body that constructs shinyNewServiceInstance
		  return shinyNewServiceInstance;
	});