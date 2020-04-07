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

timeItRepeatSRENGHT = 2 -- the default step of cycle of the auto farm

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

doStreghtAutoFarm = function()
    repeat wait() until Humanoid.WalkSpeed == 16
    local findAvailaible = function()
        trainingDevice = {
            Crunches     = {workspace.Crunches.In_Use.Value   ;Vector3.new(-142.26973, 3.69035339, -64.4220047 );
                            workspace.Crunches.Player};
            Leg_Lift     = {workspace.Leg_Lift.In_Use.Value   ;Vector3.new(-127.155914, 3.69005132, -65.509613 );
                            workspace.Leg_Lift.Player};
            Squat_Jumps  = {workspace.Squat_Jumps.In_Use.Value;Vector3.new(-113.031052, 3.69005132, -65.5107956);
                            workspace.Squat_Jumps.Player};
            Push_Ups     = {workspace.Push_Ups.In_Use.Value   ;Vector3.new(-97.0513, 3.69003153, -66.1871414   );
                            workspace.Push_Ups.Player};
            Overhead1    = {workspace.Overhead1.In_Use.Value  ;Vector3.new(-95.6423416, 3.50129175, 63.8929062 );
                            workspace.Overhead1.Player};
            Bicep1       = {workspace.Bicep1.In_Use.Value     ;Vector3.new(-108.193413, 3.50129175, 60.8449173 );
                            workspace.Bicep1.Player};
            Squat1       = {workspace.Squat1.In_Use.Value     ;Vector3.new(-118.741066, 3.50129128, 61.4322205 );
                            workspace.Squat1.Player};
            Bench1       = {workspace.Bench1.In_Use.Value     ;Vector3.new(-130.319031, 3.44129109, 57.6213875 );
                            workspace.Bench1.Player};
        }
        for i,v in pairs( trainingDevice ) do
            if v[1] == false then
                return v
            end
        end
    end
    onPathBlocked = function(blockedWaypointIndex)
        if blockedWaypointIndex > currentWaypointIndex then
            if workspace.breadcrumb then
                destroyBreadcrumb()
            end
            print(debug.traceback("Blocked. Repathing."))
            pathfind(findAvailaible()[2],true)
        end
    end
    -- TODO : FIX UP THE THING WHERE I CAN'T LOOP TWO OR MORE CYCLE(Issue #1)
    local PathfindingService = game:GetService("PathfindingService")
    for _ = 1,timeItRepeatSRENGHT do
        repeat
            wait()
        until Humanoid.WalkSpeed == 16
        toolToFarmOn = findAvailaible()
        local path = pathfind(toolToFarmOn[2],true)
        path.Blocked
        local timeSinceNoGui = tick()
        repeat wait()
            if tick() - timeSinceNoGui >= 3 then
                warn(debug.traceback"It has been more than 3 second with no GUI. Attempting to jump to show the GUI.")
                Humanoid.Jump = true
                break
            end
        until trainingGui.Exercise_Prompt.Exercise_Name.Value ~= ""
        emulateBtnClick(trainingGui.Exercise_Prompt)
    end
end

doStreghtAutoFarm()