var servicesApp = angular.module('controllers', [])

	.controller("DesignController", function($scope, $http) {
	
		$scope.title = "Design";
	})

	.controller("MainCtrl", function($scope, $http, $location) {
	
		$scope.title = "TITLE";
	});