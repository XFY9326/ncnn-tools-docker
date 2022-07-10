# ncnn-tools-docker

使用Docker在本地运行NCNN的工具  
Dockerfile for ncnn tools  

适用于不想编译完整ncnn但是需要转换或者量化模型的需求  
It is suitable for those who do not want to compile a complete ncnn but need to convert or quantize the model  

## Tools
目前可用：  
Currently support:   

- caffe2ncnn
- mxnet2ncnn
- ncnn2mem
- ncnnmerge
- onnx2ncnn
- darknet2ncnn
- ncnn2int8
- ncnn2table
- ncnnoptimize
- pnnx *

以上所有工具可以在环境中直接调用  
All above tools can be called directly in the environment  

## Usage

### Pre-build Verision

预构建版本只会下载Tencent/ncnn下最新的release进行部署  
The pre-build version will only download the latest release under Tencent/ncnn for deployment  

注意：当前预构建版本不支持pnnx  
Attention: The current pre-build version does not support pnnx

更改以下参数以切换不同的ncnn版本：  
Change the following parameters to switch between different ncnn versions:  

```dockerfile
ARG NCNN_VERSION=<version>
```

### Latest-build Version

最新构建版本会下载当前Tencent/ncnn最新的源码进行编译  
The latest build version will download the latest source code of Tencent/ncnn for compilation  

这个版本会编译pnnx  
This version will compile pnnx  

## Thanks

[ncnn](https://github.com/Tencent/ncnn)
