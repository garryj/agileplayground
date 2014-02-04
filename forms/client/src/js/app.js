var app = angular.module('app', ['controllers', 'directives', 'services']).config(function($routeProvider) {

	$routeProvider.when('/design', {
		templateUrl: 'Design.html',
		controller: 'DesignController'
	});

	$routeProvider.otherwise({ redirectTo: '/design' });

});