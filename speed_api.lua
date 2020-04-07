--Game Variable--
Players = game:GetService('Players')
LocalPlayer = Players.LocalPlayer
PlayerGui = LocalPlayer.PlayerGui
    trainingGui = PlayerGui.Training_Guis
PlayerScript = LocalPlayer.PlayerScripts
StarterPlayer = game.StarterPlayer
StarterPlayerScript = game.StarterPlayer.StarterPlayerScripts
StarterCharacterScript= StarterPlayer.StarterCharacterScripts
StarterGui = game.StarterGui
ReplicatedStorage = game.ReplicatedStorage
ReplicatedFirst = game:GetService('ReplicatedFirst')
Backpack = LocalPlayer.Backpack
Character = LocalPlayer.Character
Humanoid = Character.Humanoid
HumanoidRootPart = Character.HumanoidRootPart

emulateBtnClick = function(btn)
    assert(btn,"Missing argument #1, must specify a btn")
    for _,signal in pairs( getconnections(btn.Activated )) do
        signal:Fire()
    end
end

-- @timeItRepeat | amount of time it will repat the autofarm useful if you want to train on a specific thing  | intended for slider. if its not used the default value will be 1
setAmountItWillRepeatStr = function(timeItRepeat)
    if timeItRepeat < 1 then
        error("error in #1, the number must be equal or bigger than 1")
    else
        timeItRepeatSRENGHT = timeItRepeat
    end
end

destroyBreadcrumb = function()
    for i,v in pairs( workspace:GetChildren() ) do
        if v.ClassName == "Folder" and v.Name == "breadcrumb" then
            v:Destroy()
        end
    end
end

pathfind = function(Position,isShowingBreadcrumb)
    local PathfindingService = game:GetService("PathfindingService");
    path = PathfindingService:CreatePath()
    if typeof(Position) ~= "Vector3" then
        error("ERROR IN #1 : The position must be a Vector",2)
        return
    end
    path:ComputeAsync(HumanoidRootPart.Position,Position)
    waypoints = {}
    if path.Status == Enum.PathStatus.Success then
        waypoints = path:GetWaypoints()
            if isShowingBreadcrumb then
                breadcrumb = Instance.new("Folder",workspace)
                breadcrumb.Name = "breadcrumb"
            end
            for _, waypoint in pairs(waypoints) do
                if isShowingBreadcrumb == true then
	                local part = Instance.new("Part")
	                part.Shape = "Ball"
	                part.Material = "Neon"
	                part.Size = Vector3.new(0.6, 0.6, 0.6)
	                part.Position = waypoint.Position
	                part.Anchored = true
	                part.CanCollide = false
                    part.Parent = game.Workspace.breadcrumb
                end
                Humanoid:MoveTo(waypoint.Position)
                Humanoid.MoveToFinished:Wait()
            end
            breadcrumb:Destroy()
    else
        error("Error: path not found");
        Humanoid:MoveTo(HumanoidRootPart.Position)
    end
end
