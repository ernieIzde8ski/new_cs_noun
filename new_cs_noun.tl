local export = {}

local titleObj = mw.title.getCurrentTitle()
local pagename = titleObj.text
local  gsub = mw.ustring.sub, mw.ustring.gsub

function export.new(frame, _args) -- _args is used when called from other Lua code

	local args = _args or frame:getParent().args

	local pos_table: {string:{string}} = {
		["n/noun/"] = { "Noun", "noun" },
		["v/verb"] = { "Verb", "verb" },
		["vform/verb form"] = { "Verb", "verb form" },
		["a/adj/adjective"] = { "Adjective", "adj" },
		["adv/adverb"] = { "Adverb", "pos|adverb" },
		["pron/pronoun"] = { "Pronoun", "pos|pronoun" },
		["pn/propn/proper/proper noun"] = { "Proper noun", "pos|proper" },
		["ph/phrase"] = { "Phrase", "phrase" },
		["intj/interjection"] = { "Interjection", "pos|interjection" },
		["conj"] = { "Conjunction", "pos|conjunction" },
		["part"] = { "Particle", "pos|particle" },
		["prep"] = { "Preposition", "pos|preposition" },
		["suf/suffix"] = { "Suffix", "pos|suffix" },
		["pref/prefix"] = { "Prefix", "pos|prefix" },
		["affix"] = { "Affix", "pos|affix" },
		["prov"] = { "Proverb", "pos|proverb" },
		["id/idiom"] = { "Idiom", "pos|idiom" },
		["adn/adnominal"] = { "Adnominal", "pos|adnominal" },
	}
	local _pos_table = pos_table; pos_table = {}
	for k, v in pairs(_pos_table) do for i in mw.text.gsplit(k, "/") do pos_table[i] = v end end

	local result = args["en"] and ("===Etymology " .. args["en"] .. "===") or "==Bulgarian=="
	local hf = args["en"] and "=" or ""

	if args["defs"] then
		result = result .. "\n{{DEFAULTSORT:" .. args["defs"] .. "}}"
	end
	if args["wp"] then
		result = result .. "\n{{wp|lang=bg" .. (args["wp"] ~= "y" and "|" .. args["wp"] or "") .. "}}"
	end
	wp_count = 2
	while args["wp" .. wp_count] do
		result = result .. "\n{{wp|lang=bg|" .. args["wp" .. wp_count] .. "}}"
		wp_count = wp_count + 1
	end

	text = args[1] ~= "" and args[1] or pagename

	-- Generate subsection for arguments like alt1, alt2, etc. in a loop.
	local function other(class, title, args)
		local code, i = "", 2

		if args[class] then
			code = code .. "\n\n===" .. hf .. title .. hf .. "===\n* {{l|bg|" .. args[class] .. "}}"

			while args[class .. i] do
				code = code .. "\n* {{l|bg|" .. args[class .. i] .. "}}"
				i = i + 1
			end
		end

		return code
	end

	result = result .. other("alt", "Alternative forms", args)

	sortkey = true

	--TODO: this etymology section
	if args["d"] or args["e"] or args["b"] or args["lb"] or args["c"] or args["co1"] or args["bl1"] or args["pr1"] or args["su1"] then
		result = result .. "\n\n"
		if not args["en"] then result = result .. hf .. "===Etymology===" .. hf .. "\n" end
		if args["c"] then
			result = result .. "{{cal|bg|" .. (args["cl"] or "en") .. (args["c"] and "|" .. args["c"] or "") .. (args["tr"] and "|tr=" .. args["tr"] or "") .. (args["t"] and "||" .. args["t"] or "") .. (args["lit"] and "|lit=" .. args["lit"] or "") .. (args["pos"] and "|pos=" .. args["pos"] or "") .. (args["g"] and "|g=" .. args["g"] or "") .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
			if args["pr1"] then
				result = result .. ", equivalent to {{pre|bg|" .. args["pr1"] .. "|" .. args["pr2"] .. (args["tr1"] and "|tr1=" .. args["tr1"] or "") .. (args["tr2"] and "|tr2=" .. args["tr2"] or "") .. (args["pos1"] and "|pos1=" .. args["pos1"] or "") .. (args["pos2"] and "|pos2=" .. args["pos2"] or "") .. (args["t1"] and "|t1=" .. args["t1"] or "") .. (args["t2"] and "|t2=" .. args["t2"] or "") .. (args["presort"] and "|sort=" .. args["presort"] or "") .. "}}"
			elseif args["su1"] then
				result = result .. ", equivalent to {{suf|bg|" .. args["su1"] .. "|" .. args["su2"] .. (args["tr1"] and "|tr1=" .. args["tr1"] or "") .. (args["tr2"] and "|tr2=" .. args["tr2"] or "") .. (args["pos1"] and "|pos1=" .. args["pos1"] or "") .. (args["pos2"] and "|pos2=" .. args["pos2"] or "") .. (args["t1"] and "|t1=" .. args["t1"] or "") .. (args["t2"] and "|t2=" .. args["t2"] or "") .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
			elseif args["co1"] then
				result = result .. ", equivalent to {{af|bg|" .. args["co1"] .. (args["alt1"] and "|alt1=" .. args["alt1"] or "") .. (args["tr1"] and "|tr1=" .. args["tr1"] or "") .. (args["pos1"] and "|pos1=" .. args["pos1"] or "") .. (args["t1"] and "|t1=" .. args["t1"] or "") .. "|" .. args["co2"] .. (args["alt2"] and "|alt2=" .. args["alt2"] or "") .. (args["tr2"] and "|tr2=" .. args["tr2"] or "") .. (args["pos2"] and "|pos2=" .. args["pos2"] or "") .. (args["t2"] and "|t2=" .. args["t2"] or "")
				co_count = 3
				while args["co" .. co_count] do
					result = result .. "|" .. args["co" .. co_count] .. (args["alt" .. co_count] and "|alt" .. co_count .. "=" .. args["alt" .. co_count] or "") .. (args["tr" .. co_count] and "|tr" .. co_count .. "=" .. args["tr" .. co_count] or "") .. (args["pos" .. co_count] and "|pos" .. co_count .. "=" .. args["pos" .. co_count] or "") .. (args["t" .. co_count] and "|t" .. co_count .. "=" .. args["t" .. co_count] or "")
					co_count = co_count + 1
				end
				result = result .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
			elseif args["bl1"] then
				result = result .. ", equivalent to a {{blend|bg|nocap=y|" .. args["bl1"] .. (args["tr1"] and "|tr1=" .. args["tr1"] or "") .. (args["pos1"] and "|pos1=" .. args["pos1"] or "") .. (args["t1"] and "|t1=" .. args["t1"] or "") .. "|" .. args["bl2"] .. (args["tr2"] and "|tr2=" .. args["tr2"] or "") .. (args["pos2"] and "|pos2=" .. args["pos2"] or "") .. (args["t2"] and "|t2=" .. args["t2"] or "")
				bl_count = 3
				while args["bl" .. bl_count] do
					result = result .. "|" .. args["bl" .. bl_count] .. (args["tr" .. bl_count] and "|tr" .. bl_count .. "=" .. args["tr" .. bl_count] or "") .. (args["pos" .. bl_count] and "|pos" .. bl_count .. "=" .. args["pos" .. bl_count] or "") .. (args["t" .. bl_count] and "|t" .. bl_count .. "=" .. args["t" .. bl_count] or "")
					bl_count = bl_count + 1
				end
				result = result .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
			end
		elseif args["pr1"] then
			result = result .. "From {{pre|bg|" .. args["pr1"] .. "|" .. args["pr2"] .. (args["tr1"] and "|tr1=" .. args["tr1"] or "") .. (args["tr2"] and "|tr2=" .. args["tr2"] or "") .. (args["pos1"] and "|pos1=" .. args["pos1"] or "") .. (args["pos2"] and "|pos2=" .. args["pos2"] or "") .. (args["t1"] and "|t1=" .. args["t1"] or "") .. (args["t2"] and "|t2=" .. args["t2"] or "") .. (args["presort"] and "|sort=" .. args["presort"] or "") .. "}}"
		elseif args["su1"] then
			result = result .. "From {{suf|bg|" .. args["su1"] .. "|" .. args["su2"] .. (args["tr1"] and "|tr1=" .. args["tr1"] or "") .. (args["tr2"] and "|tr2=" .. args["tr2"] or "") .. (args["pos1"] and "|pos1=" .. args["pos1"] or "") .. (args["pos2"] and "|pos2=" .. args["pos2"] or "") .. (args["t1"] and "|t1=" .. args["t1"] or "") .. (args["t2"] and "|t2=" .. args["t2"] or "") .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
		elseif args["co1"] then
			result = result .. "From {{af|bg|" .. args["co1"] .. (args["alt1"] and "|alt1=" .. args["alt1"] or "") .. (args["tr1"] and "|tr1=" .. args["tr1"] or "") .. (args["pos1"] and "|pos1=" .. args["pos1"] or "") .. (args["t1"] and "|t1=" .. args["t1"] or "") .. "|" .. args["co2"] .. (args["alt2"] and "|alt2=" .. args["alt2"] or "") .. (args["tr2"] and "|tr2=" .. args["tr2"] or "") .. (args["pos2"] and "|pos2=" .. args["pos2"] or "") .. (args["t2"] and "|t2=" .. args["t2"] or "")
			co_count = 3
			while args["co" .. co_count] do
				result = result .. "|" .. args["co" .. co_count] .. (args["alt" .. co_count] and "|alt" .. co_count .. "=" .. args["alt" .. co_count] or "") .. (args["tr" .. co_count] and "|tr" .. co_count .. "=" .. args["tr" .. co_count] or "") .. (args["pos" .. co_count] and "|pos" .. co_count .. "=" .. args["pos" .. co_count] or "") .. (args["t" .. co_count] and "|t" .. co_count .. "=" .. args["t" .. co_count] or "")
				co_count = co_count + 1
			end
			result = result .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
		elseif args["bl1"] then
			result = result .. "{{blend|ja|" .. args["bl1"] .. (args["tr1"] and "|tr1=" .. args["tr1"] or "") .. (args["pos1"] and "|pos1=" .. args["pos1"] or "") .. (args["t1"] and "|t1=" .. args["t1"] or "") .. "|" .. args["bl2"] .. (args["tr2"] and "|tr2=" .. args["tr2"] or "") .. (args["pos2"] and "|pos2=" .. args["pos2"] or "") .. (args["t2"] and "|t2=" .. args["t2"] or "")
			bl_count = 3
			while args["bl" .. bl_count] do
				result = result .. "|" .. args["bl" .. bl_count] .. (args["tr" .. bl_count] and "|tr" .. bl_count .. "=" .. args["tr" .. bl_count] or "") .. (args["pos" .. bl_count] and "|pos" .. bl_count .. "=" .. args["pos" .. bl_count] or "") .. (args["t" .. bl_count] and "|t" .. bl_count .. "=" .. args["t" .. bl_count] or "")
				bl_count = bl_count + 1
			end
			result = result .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
		elseif args["b"] then
			result = result .. "{{bor+|bg|" .. (args["bl"] or "en") .. (args["b"] and "|" .. args["b"] or "") .. (args["tr"] and "|tr=" .. args["tr"] or "") .. (args["t"] and "||" .. args["t"] or "") .. (args["lit"] and "|lit=" .. args["lit"] or "") .. (args["pos"] and "|pos=" .. args["pos"] or "") .. (args["g"] and "|g=" .. args["g"] or "") .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
		elseif args["lb"] then
			result = result .. "{{lbor|bg|" .. (args["lbl"] or "grc") .. (args["lb"] and "|" .. args["lb"] or "") .. (args["tr"] and "|tr=" .. args["tr"] or "") .. (args["t"] and "||" .. args["t"] or "") .. (args["lit"] and "|lit=" .. args["lit"] or "") .. (args["pos"] and "|pos=" .. args["pos"] or "") .. (args["g"] and "|g=" .. args["g"] or "") .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
		else
			result = result .. (args["e"] or
				("From {{der|bg|" .. (args["dl"] or "en") .. (args["d"] and "|" .. args["d"] or "") .. (args["tr"] and "|tr=" .. args["tr"] or "") .. (args["t"] and "||" .. args["t"] or "") .. (args["lit"] and "|lit=" .. args["lit"] or "") .. (args["pos"] and "|pos=" .. args["pos"] or "") .. (args["g"] and "|g=" .. args["g"] or "") .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"))
		end
	end

	-- Add pronunciation
	result = result .. "\n\n" .. hf .. "===Pronunciation===" .. hf .. "\n* {{bg-IPA" .. (args[1] ~= "" and "|" .. gsub(text, '%^', '') or "" .. "}}")
	acc_count = 2
	while args["acc" .. acc_count] do
	    result = result .. "\n* {{bg-IPA" .. args["acc" .. acc_count] .. "}}"
		acc_count = acc_count + 1
	end

	if args["hmp"] then
		result = result .. (args["hmp"] and "{{hmp|bg|" .. args["hmp"] or "")
		hmp_count = 2
		while args["hmp" .. hmp_count] do
			result = result .. "|" .. args["hmp" .. hmp_count]
			hmp_count = hmp_count + 1
		end
		result = result .. "}}"
	end

	if args["eg"] then
		args[3] = args[3] .. "\n#" .. args["eg"]
	end
	local eg_count = 2
	while args["eg" .. eg_count] do
		args[3] = args[3] .. "\n#" .. args["eg" .. eg_count]
		eg_count = eg_count + 1
	end

	local function add_pos(header, template_name, def)
		result = result .. "\n\n" .. hf .. "===" .. header .. "===" .. hf .. "\n{{bg-" .. template_name ..
			(args[1] ~= "" and "|" .. text or "")

		if template_name == "verb" then
			result = result .. (args["a"] and "|" .. args["a"] or "")
			if args["ac"] then
				ac = (args["a"] == "pf") and "impf" or "pf"
				result = result .. "|" .. ac .. "=" .. args["ac"]
			end
		end

		if template_name == "noun" then
			result = result .. (args["g"] and "|" .. args["g"] or "")
			result = result .. (args["adj"] and "|adj=" .. args["adj"])
		end

		result = result .. "}}"

		result = result .. "\n\n# " .. (def or "{{rfdef|bg}}")

		if header == "Adjective" or header == "Noun" then
			a_or_n = (header == "Adjective") and "a" or "n"
			result = result .. "\n\n" .. hf .. "====Declension====" .. hf .. "\n"
			result = result .. "{{bg-" .. a_or_n .. "decl|" .. text .. "<" .. (args["infl"] or "") .. ">"
		end

		if header == "Verb" then
			result = result .. "\n\n" .. hf .. "====Conjugation====" .. hf .. "\n"
			result = result .. "{{bg-conj" .. "|" .. text .. "<" .. (args["infl"] or "") .. ">"
		end
	end

	if not pos_table[args[2]] then error("The POS code " .. args[2] .. " is not valid. See [[Module:bg-new]] for a list of valid POS.") end
	add_pos(pos_table[args[2]][1], pos_table[args[2]][2], args[3])
	if args["use"] then
		result = result .. "\n\n" .. hf .. "====Usage notes====" .. hf .. "\n* " .. args["use"]
	end
	result = result .. other("syn", "=Synonyms=", args)
	result = result .. other("ant", "=Antonyms=", args)
	result = result .. other("der", "=Derived terms=", args)
	result = result .. other("rel", "=Related terms=", args)

	if args[4] then
		if not pos_table[args[4]] then error("The POS code " .. args[4] .. " is not valid. See [[Module:ja-new]] for a list of valid POS.") end
		add_pos(pos_table[args[4]][1], pos_table[args[4]][2], args[5])
		if args["Use"] then
			result = result .. "\n\n" .. hf .. "====Usage notes====" .. hf .. "\n* " .. args["Use"]
		end
		result = result .. other("Syn", "=Synonyms=", args)
		result = result .. other("Ant", "=Antonyms=", args)
		result = result .. other("Der", "=Derived terms=", args)
		result = result .. other("Rel", "=Related terms=", args)
	end

	if args[6] then
		if not pos_table[args[6]] then error("The POS code " .. args[6] .. " is not valid. See [[Module:ja-new]] for a list of valid POS.") end
		add_pos(pos_table[args[6]][1], pos_table[args[6]][2], args[7])
		if args["USE"] then
			result = result .. "\n\n" .. hf .. "====Usage notes====" .. hf .. "\n* " .. args["Use"]
		end
		result = result .. other("SYN", "=Synonyms=", args)
		result = result .. other("ANT", "=Antonyms=", args)
		result = result .. other("DER", "=Derived terms=", args)
		result = result .. other("REL", "=Related terms=", args)
	end

	if args[8] then error("this template only supports up to three POS, please ask someone to expand me") end

	result = result .. other("ana", "Anagrams", args)
	result = result .. other("also", "See also", args)

	if args["ref"] ~= "n" then
		result = result .. "\n\n===References===\n"
		if args["ref"] == "1" then
			result = result .. "* {{R:bg:RBE}}"
		elseif args["ref"] == "2" then
			result = result .. "* {{R:bg:RBE2}}"
		else
			result = result .. "* {{R:bg:RBE}}\n* {{R:bg:RBE2}}"
		end
	end

	if args["cn"] then
		result = result .. "\n\n{{cln|bg|" .. args["cn"]
	cn_count = 2
	while args["cn" .. cn_count] do
		result = result .. "|" .. args["cn" .. cn_count]
		cn_count = cn_count + 1
	end
		result = result .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
	end
	if args["ct"] then
		result = result .. (args["cn"] and "\n" or "\n\n") .. "{{C|bg|" .. args["ct"]
	ct_count = 2
	while args["ct" .. ct_count] do
		result = result .. "|" .. args["ct" .. ct_count]
		ct_count = ct_count + 1
	end
		result = result .. (args["defs"] and "" or args["sort"] and "|sort=" .. args["sort"] or sortkey or "") .. "}}"
	end

	return result
end

return export
