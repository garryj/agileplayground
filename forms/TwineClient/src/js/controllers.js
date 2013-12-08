var servicesApp = angular.module('controllers', [])

	.controller("controller", function($scope, $location) {
	
		$scope.title = "My Project";

		$scope.setRoute = function(route){
            $location.path(route);
        };
        
        $scope.setIsAlertVisible = function(isVisible) {
        	$scope.isAlertVisible = isVisible;
        	$scope.$apply();
        }
        
        $scope.setAlert = function(message) {
        	$scope.message = message;
        	$scope.$apply();
        }
		
		$scope.setIsInfoPanelVisible = function(isVisible) {
			$scope.isInfoPanelVisible = isVisible;
			$scope.$apply();
		};
		
        $scope.setInfoPanel = function(ID) {
        	$scope.infoID = ID;
        	$scope.$apply();
        }
		
		$scope.setIsRightPanelVisible = function(isVisible) {
			$scope.isRightPanelVisible = isVisible;
			$scope.$apply();
		};
	});