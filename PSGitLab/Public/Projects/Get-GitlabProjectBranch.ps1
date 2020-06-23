Function Get-GitLabProjectBranch {
	[cmdletbinding()]
	#[OutputType('GitLab.Project.Branch')]
	param(
		[ValidateNotNull()]
		[ValidateNotNullOrEmpty()]
		[Parameter(ParameterSetName='Id')]
		[string]$Id
	)
	
		$queryID = $null
		switch ($PSCmdlet.ParameterSetName) {
			'Id' { $queryID = $id }
			'Namespace' { $queryID = $Namespace -replace '/','%2F' -replace ' ','' }
		}
	
		$Request = @{
			URI="/projects/$queryID/repository/branches";
			Method='Get';
		}
	
		QueryGitLabAPI -Request $Request #-ObjectType 'GitLab.Project.Branch'
	
	
	}
	