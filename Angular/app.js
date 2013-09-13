var app = angular.module("app", []).config(function($routeProvider) {

  $routeProvider.when('/post', {
    templateUrl: 'post.html',
    controller: 'PostController'
  });

  $routeProvider.otherwise({ redirectTo: '/post' });

});

app.controller("PostController", function($scope, $http) {

	$scope.title = "Post";
	
	$scope.performPost = function() {
	
		$http({method: 'GET', url: 'http://localhost:8081/controller/TestServlet'}).
		  success(function(data, status, headers, config) {
			
			$scope.forms = data;
		  }).
		  error(function(data, status, headers, config) {
			
			$scope.status = status;
		  });
	
	/*
		$http({
			url: 'http://localhost:8081/controller/TestServlet',
			method: "POST",
			data: "",
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		}).success(function (data, status, headers, config) {
			$scope.forms = data;
			}).error(function (data, status, headers, config) {
				$scope.status = status;
				});*/
	}
});