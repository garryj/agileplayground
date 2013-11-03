var app = angular.module("app", []).config(function($routeProvider) {

  $routeProvider.when('/post', {
    templateUrl: 'post.html',
    controller: 'PostController'
  });

  $routeProvider.otherwise({ redirectTo: '/post' });

});

app.config(function($httpProvider){
	$httpProvider.defaults.useXDomain = true;
	delete $httpProvider.defaults.headers.common['X-Requested-With'];
});

app.controller("PostController", function($scope, $http) {

	$scope.title = "Post";
	
	$scope.performPost = function() {
	
		/*$http({method: 'GET', url: 'http://localhost:8081/controller/TestServlet'}).
		  success(function(data, status, headers, config) {
			
			$scope.hasFailed = "SUCCESS";
			$scope.status = status;
			$scope.data = data;
		  }).
		  error(function(data, status, headers, config) {
			
			$scope.hasFailed = "FAIL";
			$scope.status = status;
			$scope.data = data;
		  });*/
	
	
		$http({
			url: 'http://localhost:8081/controller/TestServlet',
			method: "POST",
			data: "",
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).success(function (data, status, headers, config) {
			$scope.hasFailed = "SUCCESS";
			$scope.status = status;
			$scope.parsedData = data;
			}).error(function (data, status, headers, config) {
				$scope.hasFailed = "FAIL";
				$scope.status = status;
				$scope.data = data;
		});
	}
});