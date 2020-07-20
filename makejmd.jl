
"""
    Remove leading spaces in a code block
"""
function slurp(text::AbstractString)
    lines = split(text,'\n')[1:end-1]
    spacecount = minimum(leadingspaces.(lines))
    newcode = join([l[spacecount+1:end] for l in lines],'\n')
    leadingnewlines = findnext(r"[^\n]",newcode,1)
    return newcode[leadingnewlines.start:end]*"\n"
end

function leadingspaces(text::AbstractString)
    k = 1
    while true
        if k > sizeof(text)
            return typemax(Int64)
        else
            if text[k] in (' ',"\t")
                k += 1
            else
                return k-1
            end
        end
    end
end

index(S::AbstractString) = Meta.parse(replace(S,r"mycode-tmp-(.*?).jl"=>s"\1"))

files = sort([f for f in readdir() if startswith(f,"mycode-tmp-")],by=index)

io = IOBuffer()
io2 = IOBuffer()

for file in files
    write(io,"```julia\n")
    write(io,slurp(read(file,String)))
    write(io,"```\n\n")
    write(io2,slurp(read(file,String)))
end

write("data1010-learning.jmd",String(take!(io)))
write("data1010-learning.jl",String(take!(io2)))
