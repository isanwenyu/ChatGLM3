## use pytorch images
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime
## lables
LABEL version="v1"
LABEL description="chatglm3-6b docker images"
LABEL maintainer="isanwenyu[https://github.com/isanwenyu]"
## workdir
WORKDIR /app
## copy all files
COPY . .
## install tools
RUN apt update && apt install -y git gcc
## install requirements and cudatoolkit
RUN pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/ && \
pip install icetk -i https://pypi.tuna.tsinghua.edu.cn/simple/ && \
conda install cudatoolkit=11.7 -c nvidia
## expose port
EXPOSE 8501 8000
## run
CMD [ "python3","openai_api.py" ]

## command for docker build 
## docker build -t chatglm3:v1 .
## command for docker run 
## docker run --rm -it -v ~/models/THUDM/chatglm3-6b:/app/THUDM/chatglm3-6b -e NVIDIA_DRIVER_CAPABILITIES=compute,utility -e NVIDIA_VISIBLE_DEVICES=all -p 7860:7860 chatglm3:v1