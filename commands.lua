local commands = {}

local event = game.ReplicatedStorage:WaitForChild("Announce")
local bool = game.ServerStorage.Status.IsActive

local dss = game:GetService("DataStoreService")
local banstore = dss:GetDataStore("banList")

function commands.errormessage(frame,text)
	local tocopy = frame:WaitForChild("COPYME")
	local cloned = tocopy:Clone()
	cloned.Text = (text)
	cloned.Parent = frame
	cloned.TextColor3 = Color3.fromRGB(255,0,0)
	cloned.Name = "cloned"
	cloned.Visible = true
end

function commands.success(frame,text)
	local tocopy = frame:WaitForChild("COPYME")
	local cloned = tocopy:Clone()
	cloned.Text = (text)
	cloned.Parent = frame
	cloned.TextColor3 = Color3.fromRGB(0,255,0)
	cloned.Name = "cloned"
	cloned.Visible = true
end

function commands.kick(executor,input,frame)
	if executor.Name == "AoSPreacher" then
		local x = string.split(input," ")
		local tokick = x[2]
		local kickmsg = x[3]
		
		if not x[2] then
			commands.errormessage(frame,"Argument 1 missing or nil")
			return
		end
		
		local isingame
		local foundplr
		
		for i,v in pairs(game.Players:GetChildren()) do
			local checkN = v.Name
			if string.upper(v.Name) == string.upper(tokick) then
				isingame = true
				foundplr = v
			end
		end
		
		if isingame then
			foundplr:Kick(kickmsg)
			commands.success(frame,"Command: " .. input .. " executed successfully.")
		else
			commands.errormessage(frame,"Player not found. Make sure you have typed the full username.")
		end
	else
		commands.errormessage(frame,"You are not authorised to execute this command.")
	end
end

function commands.cmds(frame)
	local tocopy = frame:WaitForChild("COPYME")
	local cloned = tocopy:Clone()
	cloned.Text = "cmds, kick, kill, clr, ration-available, ration-suspend, lockdown, quarantine, white-judgement, ban, unban. Remember to type full usernames (capitalisation not important)"
	cloned.Parent = frame
	cloned.Name = "cloned"
	cloned.TextScaled = true
	cloned.Visible = true
	-- {0, 795},{0, 30}
	cloned.Size = UDim2.new(0.984,0,0.027,0)
	commands.success(frame,"cmds executed successfully.")
end

function commands.clr(frame)
	for i,v in pairs(frame:GetChildren()) do
		if v.Name ~= "COPYME" then
			v:Destroy()
		end
	end
end

function commands.kill(executor,input,frame)
	if executor.Name == "AoSPreacher" then
		
		local x = string.split(input," ")
		local tokill = x[2]
		
		if not x[2] then
			commands.errormessage(frame,"Argument 1 missing or nil")
			return
		end
		
		local isingame
		local foundplr

		for i,v in pairs(game.Players:GetChildren()) do
			local checkN = v.Name
			if string.upper(v.Name) == string.upper(tokill) then
				isingame = true
				foundplr = v
			end
		end

		if isingame then
			local char = foundplr.Character
			local humanoid = char:WaitForChild("Humanoid")
			humanoid.Health = 0
			commands.success(frame,"Command: " .. input .. " executed successfully.")
		else
			commands.errormessage(frame,"Player not found. Make sure you have typed the full username.")
		end
	else
		commands.errormessage(frame,"You are not authorised to execute this command.")
	end
end

-- 1 = alert
-- 2 = regualr

function commands.alert(gui,text,atype,frame,input,executor)
	print("t")
	if not bool.Value then
		if atype == 1 then
			event:FireAllClients(1,text)
		elseif atype == 2 then
			event:FireAllClients(2,text)
		end
	else
		event:FireAllClients(3)
	end
	commands.success(frame,"Command: " .. input .. " executed successfully.")
end

function commands.ban(frame,input,executor)
	local x = string.split(input)
end

return commands
