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




function Element(ID, type, x, y, width, height, children, parent) {
	this.ID = ID;
	this.type = type;
	this.x = x;
	this.y = y;
	this.width = width;
	this.height = height;
	this.children = children;
	this.parent = parent;
}
Element.prototype = {
	getID: function() {
		return this.ID;
	},
	getType: function() {
		return this.type;
	},
	getX: function() {
		return this.x;
	},
	getY: function() {
		return this.y;
	},
	getWidth: function() {
		return this.width;
	},
	getHeight: function() {
		return this.height;
	},
	getChildren: function() {
		return this.children;
	},
	getParent: function() {
		return this.parent;
	},
	setID: function(ID) {
		this.ID = ID;
	},
	setType: function(type) {
		this.type = type;
	},
	setX: function(x) {
		this.x = x;
	},
	setY: function(y) {
		this.y = y;
	},
	setWidth: function(width) {
		this.width = width;
	},
	setHeight: function(height) {
		this.height = height;
	},
	addChild: function(child) {
		this.children.push(child);
	},
	removeChild: function(child) {
		for(var i = 0; i < this.children.length; i++) {
			if(this.children[i].ID == child.ID) {
				this.children.splice(i, 1);
			}
		}
	},
	setParent: function(parent) {
		this.parent = parent;
	}
}