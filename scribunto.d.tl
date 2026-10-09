global type FrameArgs = {string | number: string}

local record ExpandTemplateOpts
    title: string
    args: {string|number: string}
end

global type Frame = record
    args: FrameArgs
    callParserFunction: function(self: Frame, name: string, ...: any): string
    expandTemplate: function(self: Frame, opts: ExpandTemplateOpts): any
    extensionTag: function(self: Frame, name: string, content: string, args: string |
        FrameArgs)
    getParent: function(self: Frame): Frame
    getTitle: function(self: Frame): string
    -- ...
end

global record mw
    record text
        decode: function(string: string, decodeNamedEntities?: boolean): string
        encode: function(string: string, charset?: string): string
        jsonDecode: function(string: string, flags?: number): any
        jsonEncode: function(value: any, flags?: number): string
        killMarkers: function(string: string): string
        listToText: function(list: {any}, separator?: string, conjunction?: string): string
        nowiki: function(string: string): string
        split: function(string: string, pattern: string, plain?: boolean): {string}
        gsplit: function(string: string, pattern: string, plain?: boolean): (function(): string)
        tag: function(name: string, attrs?: boolean | {string:string|number}, content?:
            boolean|string|number): string
        trim: function(string: string, charset?: string): string
        truncate: function(text: string, length: number, ellipsis?: string, adjustLength?:
        boolean): string
        unstripNoWiki: function(string: string): string
        unstrip: function(string: string): string
    end

    type Title = record
        id: number
        interwiki: string
        namespace: number
        fragment: string
        nsText: string
        subjectNsText: string
        talkNsText: string
        text: string
        -- TODO: fill out more fields:
        -- https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Title_library
    end

    type TitleBatch = record
        lookupExistence: function(self: TitleBatch): TitleBatch
        getTitles: function(self: TitleBatch): {Title}
    end

    record title
        equals: function(a: Title, b: Title): boolean
        compare: function(a: Title, b: Title): number
        getCurrentTitle: function(): Title
        new: function(idOrTitle: string | number, namespace?: string): Title
        newBatch: function(pageTitles: {string}, namespace?: string): TitleBatch
        makeTitle: function(namespace: string, title: string, fragment?: string, interwiki?: string): Title
    end

    record ustring
        maxPatternLength: number
        maxStringLength: number
        byte: function(s: string, i?: number, j?: number): {number}
        byteoffset: function(s: string, l?: number, i?: number): number
        char: function(...: number): string
        codepoint: function(s: string, i?: string, j?: string): {any}
        find: function(s: string, pattern: string, init?: string, plain?: boolean): {number} | nil
        format: function(formatstring: string, ...: any): string
        gcodepoint: function(s: string, i?: integer, j?: integer): function(): integer, integer, string
        gmatch: function(s: string, pattern: string): function(): any
        gsub: function(s: string, pattern: string, repl: string | number | {string:string
        | number} | function(...: any): any)
        isutf8: function(string): boolean
        len: function(s: string): number | nil
        lower: function(s: string): string
        match: function(s: string, pattern: string, init?: number): any
        rep: function(s: string, n: number): string
        sub: function(s: string, i: number, j: number): string
        -- TODO: fill out more fields:
        -- https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Ustring_library
    end
end
