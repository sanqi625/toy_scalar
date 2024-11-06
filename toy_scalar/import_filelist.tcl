# import_filelist.tcl
# 设置项目名称和路径
set project_name    "toy_scalar_fpga"
set project_dir     "/home/liuyunqi/jiaoyd/toy_board"
set TOY_SCALAR_PATH  "/home/liuyunqi/jiaoyd/toy_soc"

# 创建新项目
create_project $project_name $project_dir -force

# 读取filelist文件
set filelist [open "$TOY_SCALAR_PATH/toy_filelist.f"]
set files [split [read $filelist] "\n"]
close $filelist

# 遍历filelist并添加每个文件到项目中
foreach file $files {
    if {[string trim $file] != ""} {
        add_files $file
    }
}

# 设置目标板或设备
set_property part xc7z020clg484-1 [current_project]

# 运行综合
#launch_runs synth_1

# 保存项目
#save_project_as create_project
