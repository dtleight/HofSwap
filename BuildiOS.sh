{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww9720\viewh9940\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 flutter build iOS\
xcodebuild -workspace Runner.xcworkspace -scheme Runner archive -archivePath Runner.xcarchive\
xcodebuild -exportArchive -archivePath Runner.xcarchive -exportOptionsPlist ../scripts/exportOptions.plist -exportPath ../scripts -allowProvisioningUpdates\
rm -fr Runner.xcarchive}