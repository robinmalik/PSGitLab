Function Get-GitLabUser {
    <#
    .SYNOPSIS
    Get users from the GitLab instance. 
    .DESCRIPTION
    Get users from the GitLab instance. 
    .EXAMPLE
    Get-GitLabUser -ID 4
    .EXAMPLE
    Get-GitLabUser -All
    .EXAMPLE
    Get-GitLabUser -Username 'fakeuser'
    .EXAMPLE
    Get-GitLabUser -Email 'fake@domain.com'
    #>
    [cmdletbinding(DefaultParameterSetName='All')]
    param(
        [Parameter(ParameterSetName='ID')]
        [string]$ID,
        
        [Parameter(ParameterSetName='All')]
        [switch]$All,

        [Parameter(ParameterSetName='Username')]
        [string]$Username,

        [Parameter(ParameterSetName='Email')]
        [string]$Email
    )
    $Request = @{
        URI = '/users'
        Method = 'GET'
    }

    switch ( $PSCmdlet.ParameterSetName) {
        'ID' { $Request.URI = "/users/$ID" }
        'All' { $Request.URI = '/users' }
    }

    if ( $PSCmdlet.ParameterSetName -eq 'Username') {
    
        QueryGitLabAPI -Request $Request -ObjectType 'GitLab.User' | where-object { $_.username -eq $Username }
    
    } elseif ( $PSCmdlet.ParameterSetName -eq 'Email') {
    
        QueryGitLabAPI -Request $Request -ObjectType 'GitLab.User' | where-object { $_.email -eq $email } 
    
    } else {
    
        QueryGitLabAPI -Request $Request -ObjectType 'GitLab.User'
    }
}