# ERC-721 部署教程	

这是一份指南，教您如何使用 ChainIDE、MetaMask 和 Solidity 在 Ethereum's Sepolia 上创建和部署一个简单的 ERC-721 智能合约。
如果你有任何问题，请加入我们的 [ChainIDE Discord!](https://discord.gg/QpGq4hjWrh)

跟随以下步骤来教您如何部署一个 ERC-721 智能合约：

1. 安装 MetaMask
2. 编写一个 ERC-721 智能合约
3. 编译该合约
4. 部署该合约
5. Mint NFT
6. 创建一份展平化合约来用于验证
7. 在 EtherScan 上验证这份已部署的合约


### 1 安装 MetaMask
当我们在区块链上部署一个智能合约或对已部署的智能合约进行交互时，我们需要 gas，为此，我们需要有一个 Web3 钱包，可以是MetaMask。让我们来安装一个 MetaMask吧。

请点击 [here](https://metamask.io/) 来安装Metamask, 同时，我们需要将网络切换为 Sepolia 并获取 Sepolia 上的测试代币。
点击 Metamask 钱包插件，登录MetaMask钱包，在设置中将测试网打开，并切换为 Sepolia。

![image-20230919140700861](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20230919140700861.png)

然后，我们可以在以下链接中领取测试代币。

[https://sepoliafaucet.com](https://sepoliafaucet.com)

[https://www.infura.io/faucet/sepolia](https://www.infura.io/faucet/sepolia)

最后，确保你的网络切换为 Sepolia 并至少有0.1的 SepoliaETH

![image-20230919141031280](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20230919141031280.png)

### 2 编写一个 ERC-721 智能合约 

你需要写下 [ERC-721](https://eips.ethereum.org/EIPS/eip-721) 智能合约中实现的所有必要函数。一般的 ERC-721 智能合约需要包含以下函数：

 - balanceOf(): 返回该用户拥有的 NFT 数量
 - ownerOf(): 返回该 token 的持有者地址
 - approve(): 授予地址 *to* 具有 tokenId 的控制权，方法成功后需触发 Approval 事件。
 - setApprovalForAll(): 授予地址_operator具有所有NFTs的控制权，成功后需触发ApprovalForAll事件。
 - getApproved(), isApprovedForAll(): 用来查询授权。
 - safeTransferFrom(): 转移NFT所有权，一次成功的转移操作必须发起 Transer 事件。
 - transferFrom(): 用来转移NFTs, 方法成功后需触发Transfer事件。调用者自己确认_to地址能正常接收NFT，否则将丢失此NFT。此函数实现时需要检查是否符合判断条件。


ChainIDE 团队已经准备了一个的 ERC-721 合约，包括所有必需的函数，您可以使用该内置模板并根据您的要求增加/删除一些函数。

### 3 编译一份 ERC-721 智能合约
现在，你可以看到模板合约 GameItem.sol ，它包括 ERC721所有需要的功能。

点击右上角的 "Connect Wallet（连接钱包）"，选择 "Injected Web3 Provider "按钮，然后选择MetaMask，连接到MetaMask钱包（Ethereum Mainnet是主网络，Sepolia 是测试网络-我们连接到 Sepolia ）。

![image-20230919141544205](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20230919141544205.png)

在完成你的智能合约后，就可以编译智能合约了。
要编译，请到 compile 模块，根据你的源代码选择一个合适的编译器，并按下Compile GameItem.sol 按钮，编译成功后，将生成源代码的ABI和字节码。
如果你的源代码中存在一些错误，它们将显示在 console 面板下。
你可能需要仔细阅读错误，相应地解决它并再次编译!

**请记下你的源代码的编译器版本，许可证和是否开启 Optimization**，因为当你在 Sepolia 上验证你的智能合约时，会需要它。

![image-20221025153740380](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221025153740380.png)


### 4 部署一份 ERC-721 智能合约
编译成功后，是时候将你编译的ERC-721智能合约部署到 Sepolia 测试网络了。
进入 “Depoly & Interaction "模块，在已编译的智能合约中选择你想部署的合约并部署 。

在这份教程中，我们将使用 GameItem 这份智能合约来进行部署。


![image-20221025154832277](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221025154832277.png)

部署成功后，在 Output（输出） 部分可以看到一个消息，提示你的智能合约已经成功部署。
你也可以在 Sepolia 测试网络上验证已部署的智能合约。在 "INTERACT（交互） "面板中你可以看到已部署的智能合约的所有功能。

![image-20221025155141914](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221025155141914.png)

### 5 Mint NFT
要铸造一个数字藏品，你需要使用 **awarditem 函数**，并使用你想空投NFT的人的钱包地址，
 token URI输入栏则为对应的metadata地址，
 在Mint之前，你需要生成Metadata，而metadata的去中心化存储更能确保该NFT的不可篡改性。为此，Chainide提供2种方式来生成metadata。

#### 5.1 使用 chainide 内置的 html 把 metadata 上传到 IPFS 中，得到 CID。

ChainIDE 已经准备了一个内置的 HTML 模板来上传 Metadata 到 IPFS 。在资源管理器面板下，你可以找到 "index.html "文件，并点击右侧的预览按钮来预览 HTML 文件的输出，在那里填写需要的信息并点击 "提交 "按钮。

![](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/Preview-CN.png)

在你点击 "提交 "按钮后，你会得到一个CID。当点击 CID 遇到504时，我们需要采用 5.2 的办法来生成 Metadata

![image-20230114125947646](https://d3gvnlbntpm4ho.cloudfront.net/ERC721_Deployment_on_Mumbai_Polygon/image-20230114125947646.png)

#### 5.2  使用 [nft storage](https://nft.storage/)，这是一个专门将文件上传到 IPFS 的网站。(其他的上传IPFS网站也可以, 如[pinata](https://www.pinata.cloud/)）

首先准备好需要上传的图片，如 ChainIDE 的 Logo。


然后进入[nft storage](https://nft.storage/)，这个一个专门将文件上传到 IPFS 的网页。

点击 "Upload" - "Choose File" - 选择一个图片，点击 Upload

![ChainIDE_Logo](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/ChainIDE_Logo.png)

![image-20221026114612844](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026114612844.png)

上传成功后，点击图片的CID，即可看到存在 IPFS 上的图片了(CID 用于指向存储在 IPFS 中的数据)。

![image-20221026114800846](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026114800846.png)

接下来，我们需要生成 Metadata 的 json 格式文件

Metadata 格式：

```json
{
    "title": "Token Metadata",
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "description": "Identifies the asset to which this token represents"
        },
        "decimals": {
            "type": "integer",
            "description": "The number of decimal places that the token amount should display - e.g. 18, means to divide the token amount by 1000000000000000000 to get its user representation."
        },
        "description": {
            "type": "string",
            "description": "Describes the asset to which this token represents"
        },
        "image": {
            "type": "string",
            "description": "A URI pointing to a resource with mime type image/* representing the asset to which this token represents. Consider making any images at a width between 320 and 1080 pixels and aspect ratio between 1.91:1 and 4:5 inclusive."
        },
        "properties": {
            "type": "object",
            "description": "Arbitrary properties. Values may be strings, numbers, object or arrays."
        }
    }
}
```

让我们在本地新建一个json文件，如：ChainIDE_Logo.json

```json
{
    "name": "ChainIDE",
    "description": "ChainIDE Logo",
    "image": "ipfs://bafkreid2t3wk4gd3xgrg4uqt2jndr5ocwycizjdqyg4tbqayjyobmyun2a",
    "properties": {
        "initials": "c",
        "rarity": "common"
    }
}
```

> name 填 NFT 的名字
>
> description 填 NFT 的介绍
>
> image 填 NFT 的图片链接，格式为 ipfs:// + CID
>
> properties 填 NFT 的特性，数量不限

创建完成之后，将 ChainIDE_Logo.json 上传到 IPFS 中。

![image-20221026114612844](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026114612844.png)

上传成功后，复制 ChainIDE_Logo.json 的 CID: bafkreicgankcckmhs7vkcoqq6frzaqz7m7rzz5rqthgmtnxpehhbdivmgi

![image-20221026141422598](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026141422598.png)

#### 5.3 metadata上传好后，返回chainide进行mint

选择 **awarditem 函数**，player为你想空投 NFT 的地址，tokenURI为metadata链接（IPFS 链接的格式统一采用 ipfs://+CID, 这里采用方法二的CID,所以 ChainIDE Logo 的链接为 [ipfs://bafkreicgankcckmhs7vkcoqq6frzaqz7m7rzz5rqthgmtnxpehhbdivmgi](ipfs://bafkreicgankcckmhs7vkcoqq6frzaqz7m7rzz5rqthgmtnxpehhbdivmgi))，点击 Submit(调用)。

![image-20221026143329226](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026143329226.png)

铸造成功后，你可以在OpenSea NFT市场上查看你的NFT了。
访问 https://testnets.opensea.io/assets/sepolia/0x0dfc512e945b8ebf6912fb6743613c3eb4bf81e3/1（将0x0dfc512e945b8ebf6912fb6743613c3eb4bf81e3 替换为你的合约地址，合约地址可采用下图方法复制），连接你的 MetaMask 钱包，并确保选择的网络是 Sepolia，你就可以在 OpenSea NFT 市场上看到已经铸造成功的 NFT。

![image-20221026143850860](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026143850860.png)


![image-20221026144009072](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026144009072.png)

### 6 创建一份展平化合约来用于验证
为了验证一个 import 了其他智能合约的智能合约，
我们需要创建一个扁平化的文件，
一个扁平化的文件将所有导入合约的源代码放在了一个文件中，
要创建一个扁平化的文件，你需要先添加一个 "flattener "插件。


![image-20221026144759724](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026144759724.png)

一旦 Flatterner 插件被激活，你就可以在屏幕右侧点击访问，如下图所示。
选择 **GameItem.sol** ，点击扁平化按钮，创建一个扁平化的文件，一旦扁平化的文件被创建。
 它将被自动复制到剪贴板上。
你可以把它粘贴到一个文件中，并保存起来供以后使用。


![image-20221026144827135](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026144827135.png)


如果你想保存扁平化的文件，点击保存按钮，一个扁平化的合约就会被保存在当前仓库中。


![image-20221026144906855](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026144906855.png)

保存的扁平化合约可以在资源管理器模块下访问。


![image-20221026144952871](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026144952871.png)

### 7  验证智能合约

#### 7.1 通过 etherscan 网页验证合约

要验证一个智能合约，你需要访问  Etherscan，点击下图按钮自动跳转到对应合约的 etherscan 页面。


![image-20221026145612886](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026145612886.png)


点击 Contract，再点击 contract 下的 Verify and Publish 。


![image-20221026145804190](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026145804190.png)

一旦你点击 Verify and Publish，你将被要求提供以下内容。

 - Contract Address: 你想验证的已部署智能合约的地址
 - Compiler Type: 选择你想验证的是单文件还是多文件
 - Compiler Version: 你之前用来编译该合约的编译器版本
 - License: 你的源代码所使用的开源许可证类型

![image-20221026145918989](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026145918989.png)

之后，你需要粘贴你在步骤5中创建的扁平化文件，并确定是否在编译过程中开启过 Optimization，点击确认，你的智能合约就会被验证。

![image-20221026150104735](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026150104735.png)

如果你的智能合约没有问题，它将被验证，你将能够看到类似于下面显示的图像。

![image-20221026150231798](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221026150231798.png)

#### 7.2 通过 etherscan api 验证合约

如果不想采用以上方式，采用 api 的方式也可以验证合约的。

到插件栏激活 etherscan-verifier 插件

![image-20221027103935634](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027103935634.png)

在右侧栏点击 etherscan-verify 插件，点击跳转图标到etherscan官网

![image-20221027110746690](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027110746690.png)

在登录页面选择登录或注册

![image-20221027111355382](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111355382.png)

选择 API Keys

![image-20221027111522996](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111522996.png)

点击 Add

![image-20221027111608852](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111608852.png)

App Name 输入一个你喜欢的名字，并点击 Create New API Key

![image-20221027111744468](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111744468.png)

这样你的 API Key Token 就生成了（注意不要给别人看到，只用来自己使用），点击图标进行复制

![image-20221027111938619](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111938619.png)

并粘贴到 ChainIDE 中

![image-20221027112048284](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027112048284.png)

复制你要验证的合约地址

![image-20221027112115438](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027112115438.png)

粘贴后，在“Compiled Contracts”中选择 GameItem， 并点击 Verify(验证)

![image-20221027112157203](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027112157203.png)

验证成功！

![image-20221027112411803](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027112411803.png)

你的智能合约被验证成功了，恭喜你，完成了本教程所有内容！