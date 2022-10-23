# log4j2 硬盘 IfAccumulatedFileSize
find . -name "log4j2.xml" | xargs grep -E "File|size|.gz"

# logback 硬盘
find . -name "logback.xml" | xargs grep -E "File|totalSizeCap|.gz"