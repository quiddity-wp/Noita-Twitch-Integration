--Enemy Shields
--Can you break them?
--curses
--130
--todo
function twitch_enemy_shields()

    local x, y = get_player_pos()
    for _, entity in pairs(EntityGetInRadiusWithTag(x, y, 1024, "enemy") or {}) do			
		if(EntityHasTag(entity, "boss_centipede") == false or EntityHasTag(entity, "boss_centipede_active") == true) then
			
			local x, y = EntityGetTransform(entity);
			local hitbox = EntityGetFirstComponent(entity, "HitboxComponent");
			local radius = nil;
			local height = 18;
			local width = 18;
			if hitbox ~= nil then
				height = tonumber(ComponentGetValue(hitbox, "aabb_max_y")) -
							 tonumber(ComponentGetValue(hitbox, "aabb_min_y"));
				width = tonumber(ComponentGetValue(hitbox, "aabb_max_x")) -
							tonumber(ComponentGetValue(hitbox, "aabb_min_x"));
			end
			radius = math.max(height, width) + 6;
			local shield = EntityLoad("data/entities/misc/animal_energy_shield.xml",x, y);
			local stats = EntityGetFirstComponent(shield, "EnergyShieldComponent" )
			if stats ~= nil then
				ComponentSetValue(stats, "energy", "1");
				ComponentSetValue(stats, "energy_required_to_shield", "0.8");
				ComponentSetValue(stats, "recharge_speed", "0.10");
			end
			local inherit_transform = EntityGetFirstComponent(shield,"InheritTransformComponent");
			if inherit_transform ~= nil then
				ComponentSetValue(inherit_transform, "parent_hotspot_tag","shield_center");
			end
			local emitters =
				EntityGetComponent(shield, "ParticleEmitterComponent") or {};
			for _, emitter in pairs(emitters) do
				ComponentSetValueValueRange(emitter, "area_circle_radius", radius,radius);
			end
			local energy_shield = EntityGetFirstComponent(shield,"EnergyShieldComponent");
			ComponentSetValue(energy_shield, "radius", tostring(radius));

			local hotspot = EntityAddComponent(entity, "HotspotComponent", {_tags = "shield_center"});
			ComponentSetValueVector2(hotspot, "offset", 0, -height * 0.3);

			if shield ~= nil then EntityAddChild(entity, shield); end
		end
    end

end
