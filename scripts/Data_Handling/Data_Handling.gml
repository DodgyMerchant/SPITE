
//all kinds of grid manipulatuion stuff



function Func_DH_grid_delete(_grid, _index, _dir, _howmuch) {
	/// scr_dh_grid_delete(grid, index, w/h);
	/// deletes a row/column of data and then resizes
	/// _grid		id
	/// _index		the index of the column or row to delete
	/// _dir w/h	type of index given. should it copy verticly or horisontally. 1=w  0=h
	/// _howmuch	how many rows/columns should be removed
	/*
	EXPLAINATION

	depending of the type of the index given the script hopies everything
	down the list the numbers of slots to remove up.
	so that effectively the not needed cells are now replaced by the lower ones

	then it resizes so that the duplicate cells at the end are cut off
	*/
	

	//given width
	if _dir
	for (var i=_index;i<ds_grid_width(_grid)-_howmuch;i++)
		{
		for (var ii=0;ii<ds_grid_height(_grid);ii++)
			_grid[# i,ii]=_grid[# i+_howmuch,ii];
		}
	//given height
	else
	for (var i=_index;i<ds_grid_height(_grid)-_howmuch;i++)
		{
		for (var ii=0;ii<ds_grid_width(_grid);ii++)
			_grid[# ii,i]=_grid[# ii,i+_howmuch];
		}

	//resize
	var _w=ds_grid_width(_grid)-_dir*_howmuch;
	var _h=ds_grid_height(_grid)-!_dir*_howmuch;
	ds_grid_resize(_grid,max(1,_w),max(1,_h));

	//resize is <=0 returns true
	if _w<=0 or _h<=0
		return true;


}

function Func_DH_grid_makespace(_grid, _index, _dir, _howmuch, _val) {
	/// scr_dh_grid_makespace(grid, index, w/h, howmuch);
	/// makes space at the given index. like moses parted the sea. so will it the grid.
	/// _grid		into
	/// _index		to insert at
	/// _dir w/h	type of index given. should it copy verticly (true) or horisontally (false).
	/// _howmuch	how many rows/columns should be created
	/// _val		value filled into the new space
	
	// the data in the index and below is lowered down by 1

	//resize
	ds_grid_resize(_grid,ds_grid_width(_grid)+_dir*_howmuch,ds_grid_height(_grid)+!_dir*_howmuch);

	//moved

	//if given a width index
	if _dir
	//starts at the bottom and works till (including) the given index
	for (var i=ds_grid_width(_grid)-1;i>_index+(_howmuch-1);i--)
		{
		for (var ii=0;ii<ds_grid_height(_grid);ii++)
		//   to				from
		_grid[# i,ii]=_grid[# i-_howmuch,ii];
		}

	//if given a height index
	else	// !_dir
	for (var i=ds_grid_height(_grid)-1;i>_index+(_howmuch-1);i--)
		{
		for (var ii=0;ii<ds_grid_width(_grid);ii++)
		//   to				from
		_grid[# ii,i]=_grid[# ii,i-_howmuch];
		}


	//new region cleared
	if _dir
		ds_grid_set_region(_grid, _index, 0, _index+(_howmuch-1), ds_grid_height(_grid), _val);
	else
		ds_grid_set_region(_grid, 0, _index, ds_grid_width(_grid), _index+(_howmuch-1), _val);


}

function Func_DH_grid_switch(_from_grid, _to_grid, _from_index, _to_index, _dir) {
	/// scr_dh_grid_switch(from_grid, to_grid, from_index, to_index,w/h);
	/// switches 2 w/h with each other  w (true)  h (false)
	/// _from_grid		the 1st grid id
	/// _to_grid		the 2nd grid id
	/// _from_index		from
	/// _to_index		to
	/// _dir  w/h		type of index given. should it copy verticly or horisontally.
	
	/*
	_from_grid
	_to_grid
	_from_index
	_to_index
	_dir
	*/
	var _hold=0;
	if _dir
		var _size=ds_grid_height(_from_grid);
	else
		var _size=ds_grid_width(_from_grid);

	for (var i=0;i<_size;i++)
		{
		if _dir
			{
			//saving copied to
			_hold=_to_grid[# _to_index,i];
			//transfer
			_to_grid[# _to_index,i]=_from_grid[# _from_index,i];
			//pasting from save
			_from_grid[# _from_index,i]=_hold;
			}
		else
			{
			//saving copied to
			_hold=_to_grid[# i,_to_index];
			//transfer
			_to_grid[# i,_to_index]=_from_grid[# i,_from_index];
			//pasting from save
			_from_grid[# i,_from_index]=_hold;
			}
		}

}
