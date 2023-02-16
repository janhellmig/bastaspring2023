$projectPath = "C:\githublearn\bastaspring2023\sourcegenerator\InitializeSamples\ClientApp\ClientApp.csproj"
$packagesFolderPath = "C:\githublearn\bastaspring2023\sourcegenerator\InitializeSamples\customer1"

# Get the parent folder of the project path
$projectFolder = Split-Path $projectPath -Parent

# Create a nuget.config file if it doesn't exist
$nugetConfigPath = Join-Path $projectFolder "nuget.config"
if (-not (Test-Path $nugetConfigPath)) {
    # $command = "dotnet new nugetconfig -o ""$projectFolder"""
    # Invoke-Expression $command
    dotnet new nugetconfig -o $projectFolder
}

# Add the packages folder path to the nuget.config file
[xml]$nugetConfig = Get-Content $nugetConfigPath
$packageSource = $nugetConfig.SelectSingleNode("//packageSources/add[@key='MyPackages']")
if ($null -eq $packageSource) {
    $packageSource = $nugetConfig.CreateElement("add")
    $packageSource.SetAttribute("key", "MyPackages")
    $packageSource.SetAttribute("value", $packagesFolderPath)
    $packageSources = $nugetConfig.SelectSingleNode("//packageSources")
    $packageSources.AppendChild($packageSource)
} else {
    $packageSource.SetAttribute("value", $packagesFolderPath)
}
$nugetConfig.Save($nugetConfigPath)

# Get all package files in the specified folder
$packageFiles = Get-ChildItem -Path $packagesFolderPath -Filter "*.nupkg"

# Iterate through each package file and add it to the project using dotnet add package command
foreach ($packageFile in $packageFiles) {
    $packageName = $packageFile.Name.Replace(".nupkg", "")
    $packageVersion = $packageName.Split(".")[-1]
    
    $command = "dotnet add ""$projectPath"" package ""$packageName"" --version ""$packageVersion"" --package-directory ""$packagesFolderPath"""
    Invoke-Expression $command
}
