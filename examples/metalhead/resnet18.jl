# 2023-05-30: correct output, but no action from TFs
# TODO try injection

# https://fluxml.ai/Metalhead.jl/dev/tutorials/pretrained/#pretrained

using Metalhead
using Images
using DataAugmentation
using Flux
using FloatTracker: TrackedFloat64, write_out_logs, set_logger

set_logger(filename="metalhead-resnet18", buffersize=1)

function tf(x)
  TrackedFloat64(x)
end

model = ResNet(18; pretrain = true);

img = Images.load(download("https://cdn.pixabay.com/photo/2015/05/07/11/02/guitar-756326_960_720.jpg"));

DATA_MEAN = tf.((0.485, 0.456, 0.406))
DATA_STD = tf.((0.229, 0.224, 0.225))

augmentations = CenterCrop((224, 224)) |>
                ImageToTensor() |>
                Normalize(DATA_MEAN, DATA_STD)

mydata = apply(augmentations, Image(img)) |> itemdata

# ImageNet labels
labels = readlines(download("https://raw.githubusercontent.com/pytorch/hub/master/imagenet_classes.txt"))

println(Flux.onecold(model(Flux.unsqueeze(tf.(mydata), 4)), labels))

write_out_logs()

