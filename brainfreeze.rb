#!/usr/bin/env ruby

class MyArray
    attr_accessor :array, :pos

    def initialize()
        @array = [0,0,0,0,0,0,0,0]
        @pos = 0
    end

    def myget()
        return @array[@pos]
    end

    def myset(value)
        @array[@pos] = value
    end

    def moveright()
        @pos += 1
    end

    def moveleft()
        @pos -= 1
    end

end

$myarray = MyArray.new()

def myeval(stuff)
    count = 0
    if stuff[0] == 'while'
        while $myarray.myget() > 0
            myeval(stuff[1])
        end
    end

    while count < stuff.length and stuff[0] != 'while'
        if stuff[count] == '['
            leftcount = 1
            rightcount = 0
            stptr = count+1
            while leftcount > rightcount
                if stuff[stptr] == '['
                    leftcount += 1
                end
                if stuff[stptr] == ']'
                    rightcount += 1
                end

                stptr += 1
                if stptr >= stuff.length and leftcount > rightcount
                    print "Missing a closing ]"
                    abort
                end
            end
            
            myind = count
            myend = stptr 

            newstuff = stuff[myind+1..myend-2]
            count += stuff[myind..myend-1].length - 1
            myeval(['while',newstuff])
        elsif stuff[count] == ']'
            print stuff, "you lose"
            print $myarray.array
            abort

        elsif stuff[count] == '+'
            $myarray.myset($myarray.myget()+1)
        elsif stuff[count] == '-'
            $myarray.myset($myarray.myget()-1)
        elsif stuff[count] == '>'
            $myarray.moveright()
        elsif stuff[count] == '<'
            $myarray.moveleft()
        elsif stuff[count] == '.'
            print $myarray.myget().chr
        elsif stuff[count] == ','
            inp = gets[0]
            $myarray.myset(inp[0].ord)
        end
        
        count += 1
    end
end

def parse(tokens)
    parseable = []
    #do stuff
    return tokens
end

ARGV.each do|a|
    prog = ""
    file = File.open(a, "r") do |infile|
        while line = infile.gets
            prog << line
        end

    proglist = prog.split(//).select{|x| '-+<>[],.'.include?(x)}
    myeval(parse(proglist))
    end
end
