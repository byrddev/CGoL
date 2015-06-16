# set up 2D array filled with random 1 and zeros
GoL = randbool(100,100)
using PyPlot
gray()
imgplot = plt.imshow(GoL, interpolation="none")
Mfilt = [true true  true; true  false  true; true true true]
for i_gen = 1:1000
    convGoL = conv2(GoL, Mfilt)

    lives2 = convGoL .== 2
    lives3 = convGoL .== 3

    twoLiveNeig =    (GoL & lives2[2:end-1,2:end-1]) 
    threeLiveNeig =  (GoL & lives3[2:end-1,2:end-1])  
    reproduce =     (~GoL & lives3[2:end-1,2:end-1])
    GoL = twoLiveNeig | threeLiveNeig | reproduce
    imgplot = plt.imshow(GoL, interpolation="none")
    plt.savefig("GoLpics/gen$i_gen.png")
end

# at the command prompt of where the files are stored
# ffmpeg -r 15 -f image2 -s 800x600 -i gen%d.png -vcodec libx264 -crf 20 CGoL.mp4
