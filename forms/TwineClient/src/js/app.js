var app = angular.module('app', [
	'ngRoute',
	'ngAnimate',
	'controllers',
	'directives',
	'services'
]);

app.config(function($routeProvider) {

	$routeProvider.when('/design', {
		templateUrl: 'Design.html',
		controller: 'controller'
	});
		
	$routeProvider.when('/code', {
		templateUrl: 'Code.html',
		controller: 'controller'
	});

	$routeProvider.when('/preview', {
		templateUrl: 'Preview.html',
		controller: 'controller'
	});

	$routeProvider.otherwise({ redirectTo: '/design' });
});