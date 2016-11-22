require 'sass'
module OriginalFunction
    def content_converter(str)
        return Sass::Script::String.new("#{str}")
    end
end
module Sass::Script::Functions
	include OriginalFunction
end

class Sass::SyntaxError
    def original_sass_backtrace_str(default_filename = "an unknown file")
		lines = message.split("\n")
		msg = lines[0] + lines[1..-1].
		map {|l| "\n" + (" " * "Error: ".size) + l}.join
		"エラーですよー。: #{msg}" +
		Sass::Util.enum_with_index(sass_backtrace).map do |entry, i|
		"\n        #{i == 0 ? 'on' : 'from'} line #{entry[:line]}" +
		" of #{entry[:filename] || default_filename}" +
		(entry[:mixin] ? ", in `#{entry[:mixin]}'" : "")
		end.join
    end
    alias old_method sass_backtrace_str
    alias sass_backtrace_str original_sass_backtrace_str
end
